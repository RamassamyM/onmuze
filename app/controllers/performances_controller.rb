require 'json'
require 'open-uri'
# PerformancesController
class PerformancesController < ApplicationController
  before_action :set_performance, only: %i(show)
  skip_before_action :authenticate_user!, only: %i(index show)

  def index
    session[:date] = params[:performance][:date]
    @performances = Performance.near(params[:performance][:address], 20)
                               .joins(:genre)
                               .where('genres.event_type = ?', params[:performance][:event_type])
                               .select { |p| available_for(p, session[:date]) }
    @genres = Genre.pluck(:event_type).uniq
  end

  def new
    @performance = Performance.new
    @genres = Genre.all.order(:event_type)
  end

  def create
    @performance = current_user.performances.new(performance_params)
    if @performance.save
      redirect_to performance_path(@performance)
    else
      @genres = Genre.all.order(:event_type)
      render :new
    end
  end

  def show
    session[:last_viewed_performance_id] = @performance.id
    @embedded_video = @performance.generate_embedded_youtube
    @soundcloud_embed = @performance.generate_embedded_soundcloud
    @embedded_instagram = @performance.generate_instagram
    @event = Event.new
    @proposal = Proposal.new
  end

  private

  def set_performance
    @performance = Performance.find(params[:id])
  end

  def performance_params
    params.require(:performance).permit(
      :user_id, :genre_id, :name, :description, :address, :youtube_url,
      :facebook_url, :instagram_url, :soundcloud_url, :avatar, :banner
    )
  end

  def available_for(performance, date)
    available = true
    if performance.proposals.any?
      performance.proposals.each do |proposal|
        if proposal.event.scheduled_at == date && proposal.status == 'confirmed'
          available = false
          break
        end
      end
    end
    available
  end
end
