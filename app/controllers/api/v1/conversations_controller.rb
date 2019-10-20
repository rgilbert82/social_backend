class Api::V1::ConversationsController < ApplicationController
  before_action :get_conversation, only: [:show, :update, :destroy]

  def index
    # TODO
  end

  def show
    render json: @conversation
  end

  def create
    @conversation = Conversation.new(conversation_params)

    if @conversation.save
      render json: @conversation
    else
      render json: { errors: @conversation.errors.full_messages.to_sentence }, status: 422
    end
  end

  def update
    if @conversation.update(conversation_params)
      render json: @conversation
    else
      render json: { errors: @conversation.errors.full_messages.to_sentence }, status: 422
    end
  end

  def destroy
    if @conversation.destroy
      render { success: 'Success' }
    else
      render json: { errors: @conversation.errors.full_messages.to_sentence }, status: 422
    end
  end

  private

  def get_conversation
    @conversation = Conversation.find(params[:id])
  end

  def conversation_params
    params.require(:conversation).permit(:title, :sender_id, :recipient_id)
  end
end
