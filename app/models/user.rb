class User < ApplicationRecord
  before_create :create_slug, :create_token

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :password
  validates_presence_of :email
  validates_uniqueness_of :email

  has_many :comments, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :event_invites, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :posts, dependent: :destroy

  has_many :friendships, dependent: :destroy
  has_many :friends, -> { where(friendships: { confirmed: true }) }, through: :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: :friend_id, dependent: :destroy
  has_many :inverse_friends, -> { where(friendships: { confirmed: true }) }, through: :inverse_friendships, source: :user

  has_many :pending_friends, -> { where(friendships: { confirmed: false }) }, through: :friendships, source: :friend
  has_many :pending_inverse_friends, -> { where(friendships: { confirmed: false }) }, through: :inverse_friendships, source: :user

  has_many :relationships, dependent: :destroy
  has_many :relations, through: :relationships
  has_many :inverse_relationships, class_name: 'Relationship', foreign_key: :relation_id, dependent: :destroy
  has_many :inverse_relations, through: :inverse_relationships, source: :user

  has_many :sent_conversations, class_name: 'Conversation', foreign_key: :sender_id, dependent: :destroy
  has_many :received_conversations, class_name: 'Conversation', foreign_key: :recipient_id, dependent: :destroy

  has_secure_password validations: false



  def all_friends
    (self.friends + self.inverse_friends).uniq.sort_by {|obj| obj.last_name }
  end

  def all_pending_friends
    (self.pending_friends + self.pending_inverse_friends).uniq.sort_by {|obj| obj.last_name }
  end

  def with_friends
    {
      user: self,
      friends: self.all_friends,
      pending_friends: self.pending_friends,
      pending_inverse_friends: self.pending_inverse_friends
    }
  end

  private

  def create_token
    new_token = SecureRandom.uuid
    self.token = new_token
  end
end
