class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :sender, class_name: 'User', foreign_key: :user_id
  belongs_to :recipient, class_name: 'User', foreign_key: :recipient_id
  validates_presence_of :body
end
