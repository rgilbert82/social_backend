class Event < ApplicationRecord
  before_create :create_slug
  
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :event_invites, dependent: :destroy
  validates_presence_of :title
end
