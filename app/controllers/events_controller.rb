class EventsController < ApplicationController

  def create
    if events_params[:place_id]
      create_an_event_in_performance_show
    else
      create_an_event_in_place_show
    end
  end

  def show
    @event = Event.find(params[:id])
    @genres = Genre.all.map(&:event_type).uniq
    @confirmed_proposals = @event.proposals.confirmed
  end

  private

  def event_params
    params.require(:event).permit(:name, :scheduled_at, :description, :place_id)

  end

  def create_an_event_in_performance_show
    @event = Event.new(events_params)
    @event.scheduled_at = DateTime.parse(events_params[:scheduled_at]) unless events_params[:scheduled_at].empty?
    if @event.save
      redirect_after_saving_event_in_performance
    else
      redirect_without_saving_event_in_performance
    end
  end

  def redirect_after_saving_event_in_performance
    respond_to do |format|
      format.html {
        redirect_to :back,
        notice: 'Event was successfully created.'
      }
      format.js
    end
  end

  def redirect_without_saving_event_in_performance
    respond_to do |format|
      format.html { render 'performances/show' }
      format.js
    end
  end

  def create_an_event_in_place_show
    @place = Place.find(params[:place_id])
    @event = @place.events.new(events_params)
    if @event.save
      redirect_to place_path(@place)
    else
      render 'places/show'
    end
  end
end
