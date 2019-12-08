class LikeSerializer < ActiveModel::Serializer
  attributes :like, :super_like, :user

  def user
    object.user.limited_attributes
  end
end
