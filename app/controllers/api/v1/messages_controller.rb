class Api::V1::MessagesController < ApplicationController
  before_action :get_message, only: [:show, :update, :destroy]

  def index
    # TODO
  end

  def show
    render json: @message
  end

  def create
    @message = Message.new(message_params)

    if @message.save
      render json: @message
    else
      render json: { errors: @message.errors.full_messages.to_sentence }, status: 422
    end
  end

  def update
    if @message.update(message_params)
      render json: @message
    else
      render json: { errors: @message.errors.full_messages.to_sentence }, status: 422
    end
  end

  def destroy
    if @message.destroy
      render { success: 'Success' }
    else
      render json: { errors: @message.errors.full_messages.to_sentence }, status: 422
    end
  end

  private

  def get_message
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:body, :unread, :user_id, :conversation_id)
  end
end
