class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @genres = Genre.all.map(&:event_type).uniq
    @last_places = Place.last(3)
    @last_events = Event.last(3)
    @last_performances = Performance.last(3)
  end
end
