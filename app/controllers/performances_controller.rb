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
  end

  def show
    session[:last_viewed_performance_id] = @performance.id
    if @performance.youtube_url != ''
      @embedded_video = generate_embedded_youtube(@performance.youtube_url).html_safe
    end
    @event = Event.new
    @proposal = Proposal.new
  end

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

  def generate_embedded_youtube(youtube_video_url)
    embed_url = youtube_video_url.match(/^(.+\?v=)(.+)(&.+)$/)
    if embed_url.nil?
      embed_url = youtube_video_url.match(/^(.+\.be\/)(.+)$/)
    end
    if embed_url.nil?
      embedded_video = ''
    else
      embedded_video = "<iframe width='300' height='200' src='https://www.youtube.com/embed/#{embed_url[2]}' frameborder='0' allowfullscreen></iframe>"
    end
    embedded_video
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
