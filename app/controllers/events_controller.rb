class EventsController < ApplicationController

  def create

  end

  def show
    @event = Event.find(params[:id])
  end

  private

  def events_params
    params.require(:event).permit(:name, :scheduled_at, :description, :place_id)
  end

end
