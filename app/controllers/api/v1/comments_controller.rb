class Api::V1::CommentsController < Api::V1::BaseController
  before_action :get_current_user, only: [:create, :update, :destroy]
  before_action :get_comment, only: [:update, :destroy]

  def create
    if @current_user && @current_user.id.to_i == comment_params[:user_id].to_i
      @comment = Comment.new(comment_params)

      if @comment.save
        render json: @comment
      else
        render json: { errors: @comment.errors.full_messages.to_sentence }, status: 422
      end
    else
      render json: { errors: "No current user found" }, status: 422
    end
  end

  def update
    @comment = Comment.find(params[:id])

    if @current_user && @current_user == @comment.user
      if @comment.update(comment_params)
        render json: @comment
      else
        render json: { errors: @comment.errors.full_messages.to_sentence }, status: 422
      end
    else
      render json: { errors: "No current user found" }, status: 422
    end
  end

  def destroy
    @comment = Comment.find(params[:id])

    if @current_user && @current_user == @comment.user
      if @comment.destroy
        render json: { success: 'Success' }
      else
        render json: { errors: @comment.errors.full_messages.to_sentence }, status: 422
      end
    else
      render json: { errors: "No current user found" }, status: 422
    end
  end

  private

  def get_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body, :post_id, :event_id, :user_id)
  end
end
