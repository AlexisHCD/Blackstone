class Admin::ContactMessagesController < ApplicationController
  before_action :set_message, only: [:show, :mark_read, :destroy]

  def index
    @messages = ContactMessage.order(created_at: :desc)
    @unread_count = ContactMessage.where(read: false).count
  end

  def show
  end

  def mark_read
    @message.update(read: true)
    redirect_to admin_contact_messages_path, notice: "Mensaje marcado como leído."
  end

  def destroy
    @message.destroy
    redirect_to admin_contact_messages_path, notice: "Mensaje eliminado."
  end

  private

  def set_message
    @message = ContactMessage.find(params[:id])
  end
end
