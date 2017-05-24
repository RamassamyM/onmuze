class EventsController < ApplicationController

  def create

  end

  def show
    @event = Event.find(params[:id])
    @genres = Genre.all.map(&:event_type).uniq
  end

  private

  def events_params
    params.require(:event).permit(:name, :scheduled_at, :description, :place_id)
  end

end
