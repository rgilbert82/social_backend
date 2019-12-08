class Conversation < ApplicationRecord
  before_create :create_slug

  belongs_to :sender, class_name: 'User', foreign_key: :sender_id
  belongs_to :recipient, class_name: 'User', foreign_key: :recipient_id
  has_many :messages, dependent: :destroy

  validates_presence_of :title

  default_scope { order(created_at: :desc) }
end
