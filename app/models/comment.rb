class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post, optional: true
  belongs_to :image, optional: true
  belongs_to :event, optional: true
  validates_presence_of :body
end
