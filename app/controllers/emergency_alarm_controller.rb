class EmergencyAlarmController < ApplicationController
  def create
    return render json: { errors: error_message, status: :unprocessable_entity } if current_user.type == "AssistantUser"
    return render json: { errors: no_user_message, status: :unprocessable_entity } if current_user.assistant_users.empty?
    current_user.assistant_users.each do |assistant_user|
      name = current_user.first_name + ' ' + current_user.last_name
      message_content = {
        message: "Emergencia solicitada por #{name}!"
      }
    end
    head :ok
  end

  private

  def error_message
    'El boton de emergencia no está disponible para los usuarios asistentes'
  end

  def no_user_message
    'No hay asistentes asociados'
  end
end
