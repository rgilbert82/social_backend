class Api::V1::RelationshipsController < ApplicationController
  before_action :get_relationship, only: [:update, :destroy]

  def index
    # TODO
  end

  def create
    @relationship = Relationship.new(relationship_params)

    if @relationship.save
      render json: @relationship
    else
      render json: { errors: @relationship.errors.full_messages.to_sentence }, status: 422
    end
  end

  def update
    if @relationship.update(relationship_params)
      render json: @relationship
    else
      render json: { errors: @relationship.errors.full_messages.to_sentence }, status: 422
    end
  end

  def destroy
    if @relationship.destroy
      render json: { success: 'Success' }
    else
      render json: { errors: @relationship.errors.full_messages.to_sentence }, status: 422
    end
  end

  private

  def get_relationship
    @relationship = Relationship.find(params[:id])
  end

  def relationship_params
    params.require(:relationship).permit(:type, :confirmed, :user_id, :relation_id)
  end
end
