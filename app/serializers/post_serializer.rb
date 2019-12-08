class PostSerializer < ActiveModel::Serializer
  attributes :id, :body, :slug, :user_id, :created_at
  has_many :comments, include: true, include_nested_associations: true
  has_many :likes, include: true, include_nested_associations: true
end
