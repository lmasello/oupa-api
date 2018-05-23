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
      render_token(token_data)
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def render_token(token_data)
    render json: {
      access_token: token_data[:token], renew_id: token_data[:renew_id]
    }, status: :ok
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :type, :first_name,
                                 :last_name)
  end

  def correct_type
    return true if !user_params[:type].present?
    User.types.keys.include? user_params[:type]
  end
end
