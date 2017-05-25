class EventsController < ApplicationController

  def create
    @place = Place.find(params[:place_id])
    @event = @place.events.new(events_params)
    if @event.save
      redirect_to place_path(@place)
    else
      render 'places/show'
    end
  end

  def show
    @event = Event.find(params[:id])
  end

private

  def events_params
    params.require(:event).permit(:name, :scheduled_at, :description, :place_id)
  end

end
