class Api::V1::EventsController < Api::V1::BaseController
  before_action :get_event, only: [:show, :update, :destroy]

  def index
    user = User.find(params[:user_id])
    @events = user.events
    render json: @events
  end

  def show
    render json: @event
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      render json: @event
    else
      render json: { errors: @event.errors.full_messages.to_sentence }, status: 422
    end
  end

  def update
    if @event.update(event_params)
      render json: @event
    else
      render json: { errors: @event.errors.full_messages.to_sentence }, status: 422
    end
  end

  def destroy
    if @event.destroy
      render json: { success: 'Success' }
    else
      render json: { errors: @event.errors.full_messages.to_sentence }, status: 422
    end
  end

  private

  def get_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :description, :location, :event_time, :user_id)
  end
end
