class AssistantUsersController < ApplicationController
  def associate_elderly_user
    byebug
    elderly_user = ElderlyUser.find_by(first_name: user_params[:first_name],
                                       last_name: user_params[:last_name])
    return render json: { errors: 'Wrong ElderlyUser id' },
                  status: :unprocessable_entity unless elderly_user.present?
    if current_user.update(elderly_user: elderly_user)
      head :no_content
    else
      render json: { errors: current_user.errors }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:elderly_user).permit(:email, :first_name, :last_name)
  end
end
