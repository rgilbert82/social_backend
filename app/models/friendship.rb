class Friendship < ApplicationRecord
  after_initialize :set_defaults, unless: :persisted?

  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates_uniqueness_of :user_id, scope: :friend_id

  private

  def set_defaults
    self.confirmed  ||= false
  end
end
