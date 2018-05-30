class EmergencyAlarmController < ApplicationController
  def create
    return render json: { errors: error_message }, status: :unprocessable_entity if current_user.type == "AssistantUser"
    return render json: { errors: no_user_message }, status: :unprocessable_entity if current_user.assistant_users.empty?
    firebase_url = 'https://fcm.googleapis.com/fcm/send'
    current_user.assistant_users.each do |assistant_user|
      name = current_user.first_name + ' ' + current_user.last_name
      message_content = {
        to: assistant_user.device_token.to_s,
        data: {
            message: "#{name} te está solicitando ayuda"
        }
      }
      HTTParty.post(firebase_url, body: message_content.to_json,
                                  headers: {
                                    'Content-Type' => 'application/json',
                                    'Authorization' => 'key=' + Rails.application.secrets.server_push_key
                                  })
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
