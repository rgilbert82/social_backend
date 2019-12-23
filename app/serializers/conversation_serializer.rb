class ConversationSerializer < ActiveModel::Serializer
  attributes :id, :title, :slug, :sender_trash, :recipient_trash,
             :sender_id, :recipient_id, :created_at,
             :has_unread_sender_messages, :has_unread_recipient_messages

  has_many :messages, include: false

  def has_unread_sender_messages
    object.messages.where({ recipient_id: object.sender_id, unread: true }).count > 0
  end

  def has_unread_recipient_messages
    object.messages.where({ recipient_id: object.recipient_id, unread: true }).count > 0
  end
end
