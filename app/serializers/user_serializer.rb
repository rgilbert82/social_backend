class UserSerializer < ActiveModel::Serializer
  attributes :id, :avatar, :email, :first_name, :last_name, :name, :birthday,
             :location, :tagline, :description, :slug, :token, :admin, :friends,
             :pending_friends, :pending_inverse_friends, :unread_messages_count

  def name
    object.name
  end

  def friends
    User.limited_attributes(object.all_friends)
  end

  def pending_friends
    User.limited_attributes(object.pending_friends)
  end

  def pending_inverse_friends
    User.limited_attributes(object.pending_inverse_friends)
  end

  def unread_messages_count
    object.unread_messages_count
  end
end
