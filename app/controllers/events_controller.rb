class EventsController < ApplicationController

  def create; end

  def show
    @event = Event.find(params[:id])
    @genres = Genre.all.map(&:event_type).uniq
    @confirmed_proposals = @event.proposals.where('status = ?', 'confirmed')
  end

  private

  def event_params
    params.require(:event).permit(:name, :scheduled_at, :description, :place_id)
  end
end
