class ConversationRecipientSerializer < ActiveModel::Serializer
  attributes :id, :title, :slug, :sender_trash, :recipient_trash,
             :sender, :recipient, :unread_messages_count, :created_at
             
  has_many :messages, include: true, include_nested_associations: true

  def sender
    object.sender.limited_attributes
  end

  def recipient
    object.recipient.limited_attributes
  end

  def unread_messages_count
    object.recipient.unread_messages_count
  end
end
