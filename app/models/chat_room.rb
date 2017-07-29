class ChatRoom < ApplicationRecord
  belongs_to :user
  has_many :chat_rooms, dependent: :destroy
  has_many :messages, dependent: :destroy
end
