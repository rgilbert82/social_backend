class Album < ApplicationRecord
  before_create :create_slug
  
  belongs_to :user
  has_many :images
  validates_presence_of :title
end
