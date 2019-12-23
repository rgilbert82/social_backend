class Message < ApplicationRecord
  before_create :set_unread

  belongs_to :conversation
  belongs_to :sender, class_name: 'User', foreign_key: :user_id
  belongs_to :recipient, class_name: 'User', foreign_key: :recipient_id
  validates_presence_of :body

  default_scope { order(created_at: :desc) }

  private

  def set_unread
    self.unread = true
  end
end
