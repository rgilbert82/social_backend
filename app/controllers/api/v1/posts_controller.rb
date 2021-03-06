class Api::V1::PostsController < Api::V1::BaseController
  before_action :get_current_user, only: [:create, :update, :destroy]
  before_action :get_post, only: [:update, :destroy]

  def index
    user = User.find(params[:user_id])
    @posts = user.posts
    render json: @posts
  end

  def create
    if @current_user && @current_user.id.to_i == post_params[:user_id].to_i
      @post = Post.new(post_params)

      if @post.save
        render json: @post
      else
        render json: { errors: @post.errors.full_messages.to_sentence }, status: 422
      end
    else
      render json: { errors: "No current user found" }, status: 422
    end
  end

  def update
    @post = Post.find(params[:id])

    if @current_user && @current_user == @post.user
      if @post.update(post_params)
        render json: @post
      else
        render json: { errors: @post.errors.full_messages.to_sentence }, status: 422
      end
    else
      render json: { errors: "No current user found" }, status: 422
    end
  end

  def destroy
    @post = Post.find(params[:id])

    if @current_user && @current_user == @post.user
      if @post.destroy
        render json: { success: 'Success' }
      else
        render json: { errors: @post.errors.full_messages.to_sentence }, status: 422
      end
    else
      render json: { errors: "No current user found" }, status: 422
    end
  end

  private

  def get_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:body, :user_id)
  end
end
