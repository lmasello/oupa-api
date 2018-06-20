class PersonalMedicineReminderController < ApplicationController
  def index
    render json: current_user.personal_medicine_reminder.where(date: Date.current).order(time: :asc)
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
