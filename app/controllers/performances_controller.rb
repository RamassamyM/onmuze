# PerformancesController
class PerformancesController < ApplicationController
  before_action :set_performance, only: %i(show)

  def index
    session[:date] = params[:date]
    @performances = Performance.near(params[:address], 20)
                               .joins(:genres)
                               .where('genres.event_type = ?', params[:event_type])
                               .select { |p| available_for(p, date) }
  end

  def show; end

  private

  def set_performance
    @performance = Performance.find(params[:id])
  end

  def performance_params
    params.require(:performance).permit(
      :user_id, :category, :name, :description, :address, :youtube_url,
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
