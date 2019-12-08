class ConversationSerializer < ActiveModel::Serializer
  attributes :id, :title, :slug, :sender_trash, :recipient_trash, :sender, :recipient, :created_at
  has_many :messages, include: true, include_nested_associations: true

  def sender
    object.sender.limited_attributes
  end

  def recipient
    object.recipient.limited_attributes
  end
end
