class PlacesController < ApplicationController
  before_action :set_place, only: %i(show update)

  def index
    @places = current_user.places
    @place = Place.where.not(latitude: nil, longitude: nil)

    # @hash = Gmaps4rails.build_markers(@places) do |place, marker|
    #   marker.lat place.latitude
    #   marker.lng place.longitude
      # marker.infowindow render_to_string(partial: "/flats/map_box", locals: { flat: flat })
    # end
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
    @event = Event.new
  end

  def update
    if @place.update(place_params)
      redirect_to @place
    else
      render :show
    end
  end

  private

  def place_params
    params.require(:place).permit(:name, :address, :description, :photo)
  end

  def set_place
    @place = Place.find(params[:id])
  end
end
