class Api::V1::FriendshipsController < Api::V1::BaseController
  before_action :get_current_user, only: [:confirm, :deny, :status]

  def status
    if @current_user && @current_user.id.to_i == friendship_params[:user_id].to_i
      user_id   = friendship_params[:user_id]
      friend_id = friendship_params[:friend_id]

      if @current_user.friends.exists?(friend_id)
        unfriend(user_id, friend_id)
      elsif @current_user.inverse_friends.exists?(friend_id)
        unfriend(friend_id, user_id)
      else
        Friendship.create(user_id: user_id, friend_id: friend_id, confirmed: false)
      end

      render json: @current_user.with_friends
    else
      render json: { errors: "No current user found" }, status: 422
    end
  end

  def confirm
    if @current_user && @current_user.id.to_i == friendship_params[:user_id].to_i
      user_id    = friendship_params[:user_id]
      friend_id  = friendship_params[:friend_id]
      friendship = Friendship.where({ user_id: friend_id, friend_id: user_id }).first

      if friendship
        friendship.update_column('confirmed', true)
        render json: @current_user.with_friends
      else
        render json: { errors: "There was an error confirming the friendship." }, status: 422
      end
    else
      render json: { errors: "No current user found" }, status: 422
    end
  end

  def deny
    if @current_user && @current_user.id.to_i == friendship_params[:user_id].to_i
      user_id    = friendship_params[:user_id]
      friend_id  = friendship_params[:friend_id]
      friendship = Friendship.where({ user_id: friend_id, friend_id: user_id }).first

      if friendship
        friendship.destroy
        render json: @current_user.with_friends
      else
        render json: { errors: "There was an error declining the friendship." }, status: 422
      end
    else
      render json: { errors: "No current user found" }, status: 422
    end
  end

  private

  def unfriend(user_id, friend_id)
    fr = Friendship.where(user_id: user_id, friend_id: friend_id).first
    Friendship.destroy(fr.id)
  end

  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id, :confirmed)
  end
end
