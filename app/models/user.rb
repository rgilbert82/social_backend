class User < ApplicationRecord
  before_create :create_slug

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :password
  validates_presence_of :email
  validates_uniqueness_of :email

  has_many :albums, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :event_invites, dependent: :destroy
  has_many :images, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :posts, dependent: :destroy

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: :friend_id, dependent: :destroy
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  has_many :relationships, dependent: :destroy
  has_many :relations, through: :relationships
  has_many :inverse_relationships, class_name: 'Relationship', foreign_key: :relation_id, dependent: :destroy
  has_many :inverse_relations, through: :inverse_relationships, source: :user

  has_many :sent_conversations, class_name: 'Conversation', foreign_key: :sender_id, dependent: :destroy
  has_many :received_conversations, class_name: 'Conversation', foreign_key: :recipient_id, dependent: :destroy

  has_secure_password validations: false
end
