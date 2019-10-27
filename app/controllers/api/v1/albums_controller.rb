class Api::V1::AlbumsController < ApplicationController
  before_action :get_album, only: [:show, :update, :destroy]

  def index
    user = User.find(params[:user_id])
    @albums = user.albums
    render json: @albums
  end

  def show
    render json: @album
  end

  def create
    @album = Album.new(album_params)

    if @album.save
      render json: @album
    else
      render json: { errors: @album.errors.full_messages.to_sentence }, status: 422
    end
  end

  def update
    if @album.update(album_params)
      render json: @album
    else
      render json: { errors: @album.errors.full_messages.to_sentence }, status: 422
    end
  end

  def destroy
    if @album.destroy
      render json: { success: 'Success' }
    else
      render json: { errors: @album.errors.full_messages.to_sentence }, status: 422
    end
  end

  private

  def get_album
    @album = Album.find(params[:id])
  end

  def album_params
    params.require(:album).permit(:title, :user_id)
  end
end
