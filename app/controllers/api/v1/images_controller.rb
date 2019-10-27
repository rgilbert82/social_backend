class Api::V1::ImagesController < ApplicationController
  before_action :get_image, only: [:show, :update, :destroy]

  def index
    # TODO
  end

  def show
    render json: @image
  end

  def create
    @image = Image.new(image_params)

    if @image.save
      render json: @image
    else
      render json: { errors: @image.errors.full_messages.to_sentence }, status: 422
    end
  end

  def update
    if @image.update(image_params)
      render json: @image
    else
      render json: { errors: @image.errors.full_messages.to_sentence }, status: 422
    end
  end

  def destroy
    if @image.destroy
      render json: { success: 'Success' }
    else
      render json: { errors: @image.errors.full_messages.to_sentence }, status: 422
    end
  end

  private

  def get_image
    @image = Image.find(params[:id])
  end

  def image_params
    params.require(:image).permit(:image_url, :description, :avatar, :background, :user_id, :album_id, :post_id)
  end
end
