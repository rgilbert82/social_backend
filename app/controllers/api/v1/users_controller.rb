class Api::V1::UsersController < Api::V1::BaseController
  before_action :get_user, only: [:update, :destroy]

  def index
    render json: User.limited_attributes(User.all)
  end

  def show
    slug = params[:id]
    user = User.where({ slug: slug }).first

    if user
      render json: user
    else
      render json: { errors: 'User not found.' }, status: 422
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user
    else
      render json: { errors: @user.errors.full_messages.to_sentence }, status: 422
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: { errors: @user.errors.full_messages.to_sentence }, status: 422
    end
  end

  def destroy
    if @user.destroy
      render json: { success: 'Success' }
    else
      render json: { errors: @user.errors.full_messages.to_sentence }, status: 422
    end
  end

  private

  def get_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :birthday, :location, :tagline, :description)
  end
end
