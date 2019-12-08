class Api::V1::SessionsController < Api::V1::BaseController
  before_action :get_current_user, only: [:show, :destroy]

  def show
    if @current_user
      render json: @current_user
    else
      render json: { errors: "No current user found" }, status: 422
    end
  end

  def create
    valid_user = User.where({ email: user_params[:email] }).first

    if valid_user && valid_user.authenticate(user_params[:password])
      update_token(valid_user)
      render json: valid_user
    else
      render json: { errors: "Invalid email or password" }, status: 422
    end
  end

  def destroy
    if @current_user
      update_token(@current_user)
      render json: @current_user
    else
      render json: { errors: "No current user found" }, status: 422
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def update_token(user)
    new_token = SecureRandom.uuid
    user.update_column('token', new_token)
  end
end
