class Api::V1::EventInvitesController < ApplicationController
  before_action :get_event_invite, only: [:show, :update, :destroy]

  def index
    event = Event.find(params[:event_id])
    @event_invites = event.event_invites
    render json: @event_invites
  end

  def show
    render json: @event_invite
  end

  def create
    @event_invite = EventInvite.new(event_invite_params)

    if @event_invite.save
      render json: @event_invite
    else
      render json: { errors: @event_invite.errors.full_messages.to_sentence }, status: 422
    end
  end

  def update
    if @event_invite.update(event_invite_params)
      render json: @event_invite
    else
      render json: { errors: @event_invite.errors.full_messages.to_sentence }, status: 422
    end
  end

  def destroy
    if @event_invite.destroy
      render json: { success: 'Success' }
    else
      render json: { errors: @event_invite.errors.full_messages.to_sentence }, status: 422
    end
  end

  private

  def get_event_invite
    @event_invite = EventInvite.find(params[:id])
  end

  def event_invite_params
    params.require(:event_invite).permit(:unread, :rsvp, :user_id, :event_id)
  end
end
