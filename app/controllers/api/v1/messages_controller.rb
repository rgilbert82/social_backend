class Api::V1::MessagesController < Api::V1::BaseController
  before_action :get_current_user, only: [:create]

  def create
    if @current_user && @current_user.id.to_i == message_params[:user_id].to_i
      @message = Message.new(message_params)

      if @message.save
        render json: @message
      else
        render json: { errors: @message.errors.full_messages.to_sentence }, status: 422
      end
    else
      render json: { errors: "No current user found" }, status: 422
    end
  end

  private

  def message_params
    params.require(:message).permit(:body, :user_id, :recipient_id, :conversation_id)
  end
end
