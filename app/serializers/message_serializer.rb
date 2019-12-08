class MessageSerializer < ActiveModel::Serializer
  attributes :id, :body, :unread, :conversation_id, :sender, :created_at

  def sender
    object.sender.limited_attributes
  end
end
