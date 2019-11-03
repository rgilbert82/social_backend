class Api::V1::SessionsController < Api::V1::BaseController
  before_action :get_current_user, only: [:show, :destroy]

  def show
    if @current_user
      render json: @current_user.with_friends
    else
      render json: { errors: "No current user found" }, status: 422
    end
  end

  def create
    valid_user = User.where({ email: user_params[:email] }).first

    if valid_user && valid_user.authenticate(user_params[:password])
      update_token(valid_user)
      render json: valid_user.with_friends
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


# curl -d '{"user":{"email":"ry.gil.online@gmail.com", "password": "password"}}' -H "Content-Type: application/json" -X POST http://localhost:3001/api/v1/sessions
# curl -H "Authorization: c324a293-2a72-400e-9ef7-178bf6221df1" -X GET http://localhost:3001/api/v1/sessions/1
# curl -H "Authorization: c324a293-2a72-400e-9ef7-178bf6221df1" -X DELETE http://localhost:3001/api/v1/sessions/1
