class UsersController < ApplicationController
  skip_before_action :current_user, :authenticate_request, only: [:create]

  def logged_in
    render json: current_user, status: :ok
  end

  def create
    return render json: { errors: 'Incorrect user type' }, status: :bad_request unless correct_type
    user = User.new(user_params)
    if user.save
      token_data = AuthenticableEntity.generate_access_token(user)
      render json: user, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if current_user.update_attributes(update_params)
      render json: current_user, status: :ok
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def associated_oupas
    return render json: { errors: no_oupas_message }, status: :unprocessable_entity if current_user.type == 'ElderlyUser'
    oupas = []
    if current_user.type == 'AssistantUser'
      oupas << current_user.elderly_user
    elsif current_user.type == 'DoctorUser'
      oupas = current_user.elderly_user
    end
    render json: oupas, status: :ok
  end

  private

  def render_token(token_data)
    render json: {
      access_token: token_data[:token], renew_id: token_data[:renew_id]
    }, status: :ok
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :type, :first_name,
                                 :last_name, :device_token, :elderly_user_id, :doctor_user_id)
  end

  def update_params
    params.require(:user).permit(:device_token, :doctor_user_id)
  end

  def correct_type
    return true if !user_params[:type].present?
    User.types.keys.include? user_params[:type]
  end

  def no_oupas_message
    'Oupas do not have associated oupas'
  end
end
