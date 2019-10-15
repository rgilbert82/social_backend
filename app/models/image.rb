class Image < ApplicationRecord
  before_create :create_slug
  
  belongs_to :user
  belongs_to :album, optional: true
  belongs_to :post, optional: true
  has_many :comments
  validates_presence_of :image_url
end
