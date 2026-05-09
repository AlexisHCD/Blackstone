class ContactMessagesController < ApplicationController
  def create
    @message = ContactMessage.new(message_params)
    if @message.save
      redirect_back fallback_location: root_path, notice: "¡Mensaje enviado! Gracias por tu feedback. 📬"
    else
      redirect_back fallback_location: root_path, alert: "Error: #{@message.errors.full_messages.join(', ')}"
    end
  end

  private

  def message_params
    params.require(:contact_message).permit(:name, :email, :message_type, :body, :tool_id)
  end
end
