class Chat < ApplicationRecord
  belongs_to :user
  has_many :messages, -> { order(created_at: :desc) }, dependent: :destroy
end
