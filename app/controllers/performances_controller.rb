class PerformancesController < ApplicationController
  before_action :set_performance, only: %i(show)

  def index
    # TODO :
    # @performances is a collection responding to search form parameters :
    # 1/ geolocalization with address
    # 2/ performance category
    # 3/ availability (date)
    @performances = Performance.all
  end

  def show; end

  private

  def set_performance
    @performance = Performance.find(params[:id])
  end

  def performance_params
    params.require(:performance).permit(
      :user_id,
      :category,
      :name,
      :description,
      :address,
      :youtube_url,
      :facebook_url,
      :instagram_url,
      :soundcloud_url
    )
  end
end
