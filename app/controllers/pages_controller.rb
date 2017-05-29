class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    # @genres = Genre.all.map(&:event_type).uniq
    @last_places = Place.last(3)
    @last_events = Event.last(3)
    @last_performances = Performance.last(3)
  end

  def search
    search_type = params[:search_type]
    if search_type == 'Events'
      search_events
    elsif search_type == 'Places'
      search_places
    elsif search_type == 'Artists'
      search_artists
    end
  end

  def search_artists
    params[:performance] = {
      date: Date.now,
      address: params[:address],
      event_type: 'Music'
    }
    redirect_to performances_path
  end

  def search_events
    @events = Event.all
    redirect_to events_path
  end

  def search_places
    @places = Place.all
    redirect_to places_path
  end
end
