class PersonalMedicineReminderController < ApplicationController
  def index
    from = Date.current.beginning_of_day
    to = Date.current.end_of_day
    user = params[:user_id].present? ? User.find(params[:user_id]) : current_user
    render json: user.personal_medicine_reminder
                     .where(date: from..to)
                     .order(time: :asc)
  end

  def create
    medicine_reminder = PersonalMedicineReminder.new(personal_medicine_reminder_params)
    if current_user.type == 'ElderlyUser'
      medicine_reminder.assign_attributes(elderly_user: current_user)
    else
      medicine_reminder.assign_attributes(elderly_user: current_user.elderly_user)
    end
    if medicine_reminder.save
      render json: medicine_reminder, status: :ok
    else
      render json: { errors: medicine_reminder.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def delete_all
    current_user.personal_medicine_reminder.delete_all
    head :no_content
  end

  def update
    medicine_reminder = PersonalMedicineReminder.find(params[:id])
    if medicine_reminder.update(personal_medicine_reminder_params)
      render json: medicine_reminder, status: :ok
    else
      render json: { errors: medicine_reminder.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def personal_medicine_reminder_params
    params.require(:personal_medicine_reminder).permit(:name, :notes, :date, :time, :taken)
  end
end
