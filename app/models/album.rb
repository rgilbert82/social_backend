class Album < ApplicationRecord
  belongs_to :user
  has_many :images
  validates_presence_of :title
end
