class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post, optional: true
  belongs_to :event, optional: true
  has_many :likes, dependent: :destroy

  validates_presence_of :body

  default_scope { order(created_at: :desc) }
end
