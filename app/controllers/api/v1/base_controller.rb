class Api::V1::BaseController < ApplicationController
  respond_to :json

  private

  def get_current_user
    token = request.headers['Authorization']
    @current_user = User.where({ token: token }).first
  end
end
