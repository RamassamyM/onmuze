class PlacesController < ApplicationController

  def new
    @place = Place.new
  end

  def create

  end

  def show
    @place = Place.find(params[:id])
  end

  private

  def

  def places_params
    params.require(:place).permit(:name, :address, :description, :photo)
  end

end
