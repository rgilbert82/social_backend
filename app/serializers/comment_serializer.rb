class CommentSerializer < ActiveModel::Serializer
  attributes :body, :id, :user, :created_at
  has_many :likes, include: true, include_nested_associations: true

  def user
    object.user.limited_attributes
  end
end
