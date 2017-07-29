class MessageBroadcastJob < ApplicationJob
  que_as :default

#method to do the actual broadcasting
  def perform(message)
    ActionCable.server.broadcast "chat_rooms_#{message.chat_room_id}_channel", message: 'MESSAGE_HTML'
  end

  private
#render html into the messages controller
  def render_message(message)
    MessagesController.render partial: 'messages/message', locals: {message: message}
  end
end
