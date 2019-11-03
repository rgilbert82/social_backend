class Api::V1::CommentsController < Api::V1::BaseController
  before_action :get_comment, only: [:update, :destroy]

  def index
    # TODO
  end

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      render json: @comment
    else
      render json: { errors: @comment.errors.full_messages.to_sentence }, status: 422
    end
  end

  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: { errors: @comment.errors.full_messages.to_sentence }, status: 422
    end
  end

  def destroy
    if @comment.destroy
      render json: { success: 'Success' }
    else
      render json: { errors: @comment.errors.full_messages.to_sentence }, status: 422
    end
  end

  private

  def get_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body, :post_id, :event_id, :image_id, :user_id)
  end
end
