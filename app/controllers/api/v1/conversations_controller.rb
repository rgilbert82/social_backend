class Api::V1::ConversationsController < Api::V1::BaseController
  before_action :get_current_user, only: [:inbox, :trash, :show, :create, :update]

  def inbox
    if @current_user && @current_user.id.to_i == params[:user_id].to_i
      @conversations = @current_user.inbox
      @conversations = { conversations: [] }.to_json if @conversations.empty?

      render json: @conversations
    else
      render json: { errors: "No current user found" }, status: 422
    end
  end

  def trash
    if @current_user && @current_user.id.to_i == params[:user_id].to_i
      @conversations = @current_user.trash
      @conversations = { conversations: [] }.to_json if @conversations.empty?

      render json: @conversations
    else
      render json: { errors: "No current user found" }, status: 422
    end
  end

  def show
    @conversation = Conversation.where({ slug: params[:id] }).first

    if !@conversation
      render json: { errors: "No conversation found" }, status: 422
    elsif @current_user && @current_user == @conversation.sender
      @conversation.mark_messages_read(@current_user)
      render json: @conversation, serializer: ConversationSenderSerializer
    elsif @current_user && @current_user == @conversation.recipient
      @conversation.mark_messages_read(@current_user)
      render json: @conversation, serializer: ConversationRecipientSerializer
    else
      render json: { errors: "No current user found" }, status: 422
    end
  end

  def create
    if @current_user && @current_user.id.to_i == message_params[:user_id].to_i
      @conversation = Conversation.new(conversation_params)
      @message      = Message.new(message_params)
      @conversation.messages << @message

      if @conversation.save
        render json: @conversation
      else
        render json: { errors: @conversation.errors.full_messages.to_sentence }, status: 422
      end
    else
      render json: { errors: "No current user found" }, status: 422
    end
  end

  def update
    @conversation = Conversation.find(params[:id])

    if @current_user && (@current_user == @conversation.sender || @current_user == @conversation.recipient)
      if @conversation.update(conversation_params)
        render json: @conversation
      else
        render json: { errors: @conversation.errors.full_messages.to_sentence }, status: 422
      end
    else
      render json: { errors: "No current user found" }, status: 422
    end
  end

  private

  def conversation_params
    params.require(:conversation).permit(:title, :sender_id, :recipient_id, :sender_trash, :recipient_trash)
  end

  def message_params
    params.require(:message).permit(:body, :user_id, :recipient_id)
  end
end
