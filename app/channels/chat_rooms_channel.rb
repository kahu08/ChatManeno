class ChatRoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_rooms#{params['chat_room_id']}_channel"
  end

  def unsubscribed

  end

#broadcast the streamed message
  def send_message(data)
    current_user.messages.create!(body: data['message'], chat_room_id: data['chat_room_id'])
  end
end
