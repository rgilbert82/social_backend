class Post < ApplicationRecord
  before_create :create_slug

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
end
