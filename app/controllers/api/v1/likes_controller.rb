class Api::V1::LikesController < Api::V1::BaseController
  before_action :get_current_user, only: [:status]

  def status
    if @current_user && @current_user.id.to_i == like_params[:user_id].to_i
      @like = Like.where({ user_id: like_params[:user_id] }).first

      if @like
        if !like_params[:like] && !like_params[:super_like]
          destroy_like
        else
          update_like
        end
      else
        create_like
      end
    else
      render json: { errors: "No current user found" }, status: 422
    end
  end

  private

  def like_params
    params.require(:like).permit(:like, :super_like, :user_id, :post_id, :comment_id)
  end

  def create_like
    @like = Like.new(like_params)

    if @like.save
      render json: @like
    else
      render json: { errors: @like.errors.full_messages.to_sentence }, status: 422
    end
  end

  def update_like
    if @like.update(like_params)
      render json: @like
    else
      render json: { errors: @like.errors.full_messages.to_sentence }, status: 422
    end
  end

  def destroy_like
    @data = {
      like: {
        like: false,
        super_like: false,
        user: { id: like_params[:user_id] }
        }
      }

    Like.destroy(@like.id)
    render json: @data
  end
end
