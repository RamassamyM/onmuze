class PlacesController < ApplicationController
  def index
    @places = current_user.places
  end

  def new
    @place = Place.new
  end

  def create
    @place = current_user.places.new(place_params)
    if @place.save
      redirect_to place_path(@place)
    else
      render :new
    end
  end

  def show
    @place = Place.find(params[:id])
    @event = Event.new
  end

  private

  def place_params
    params.require(:place).permit(:name, :address, :description, :photo)
  end
end
