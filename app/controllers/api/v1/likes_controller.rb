class Api::V1::LikesController < ApplicationController
  before_action :get_like, only: [:show, :update, :destroy]

  def index
    # TODO
  end

  def show
    render json: @like
  end

  def create
    @like = Like.new(like_params)

    if @like.save
      render json: @like
    else
      render json: { errors: @like.errors.full_messages.to_sentence }, status: 422
    end
  end

  def update
    if @like.update(like_params)
      render json: @like
    else
      render json: { errors: @like.errors.full_messages.to_sentence }, status: 422
    end
  end

  def destroy
    if @like.destroy
      render json: { success: 'Success' }
    else
      render json: { errors: @like.errors.full_messages.to_sentence }, status: 422
    end
  end

  private

  def get_like
    @like = Like.find(params[:id])
  end

  def like_params
    params.require(:like).permit(:like, :super_like, :user_id, :post_id, :image_id)
  end
end
