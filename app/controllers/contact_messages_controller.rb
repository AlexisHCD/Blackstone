class ContactMessagesController < ApplicationController
  def create
    @message = ContactMessage.new(message_params)
    if @message.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_back fallback_location: root_path, notice: "¡Mensaje enviado! Gracias por tu feedback." }
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("contact-form", partial: "shared/contact_form", locals: { message: @message }) }
        format.html { redirect_back fallback_location: root_path, alert: "Hubo un error al enviar el mensaje." }
      end
    end
  end

  private

  def message_params
    params.require(:contact_message).permit(:name, :email, :message_type, :body, :tool_id)
  end
end
