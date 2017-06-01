class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:startdirect, :home]
  before_action :set_searched_in_session, only: :home

  def startdirect
   if !user_signed_in?
    redirect_to home_path
   elsif current_user.places.empty? && current_user.performances.empty?
    redirect_to choose_path
   elsif current_user.places.count + current_user.performances.count > 1
    redirect_to dashboard_path
   elsif current_user.places.count == 1
    @place = current_user.places.first
    redirect_to place_path(@place)
   else
    @performance = current_user.performances.first
    redirect_to performance_path(@performance)
   end
  end

  def home
    @genres = Genre.all.map(&:event_type).uniq
    @last_places = Place.last(3)
    @last_events = Event.last(3)
    @last_performances = Performance.last(3)
  end

  def choose
  end

end
