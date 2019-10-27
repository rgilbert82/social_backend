class Api::V1::FriendshipsController < ApplicationController
  before_action :get_friendship, only: [:update, :destroy]

  def index
    # TODO
  end

  def create
    @friendship = Friendship.new(friendship_params)

    if @friendship.save
      render json: @friendship
    else
      render json: { errors: @friendship.errors.full_messages.to_sentence }, status: 422
    end
  end

  def update
    if @friendship.update(friendship_params)
      render json: @friendship
    else
      render json: { errors: @friendship.errors.full_messages.to_sentence }, status: 422
    end
  end

  def destroy
    if @friendship.destroy
      render json: { success: 'Success' }
    else
      render json: { errors: @friendship.errors.full_messages.to_sentence }, status: 422
    end
  end

  private

  def get_friendship
    @friendship = Friendship.find(params[:id])
  end

  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id)
  end
end
