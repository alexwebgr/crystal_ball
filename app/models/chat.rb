class Chat < ApplicationRecord
  has_many :messages,
    -> { order(created_at: :desc) },
    dependent: :destroy

  # acts_as_chat
  #
  broadcasts_to ->(chat) { "chat_#{chat.id}" }
end
