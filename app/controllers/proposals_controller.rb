class ProposalsController < ApplicationController
  before_action :set_proposal, only: %i(show)

  def index
    @proposals = current_user.proposals
  end

  def show; end

  def create
    @performance = Performance.find(params[:performance_id])
    @proposal = @performance.proposals.new(event_id: proposal_params[:event_id])
    if @proposal.save
      @event = @proposal.event
      UserMailer.send_proposal(@performance, @proposal.event).deliver_now
      redirect_to event_path(@event)
    else
      @event = Event.new
      render 'performances/show'
    end
  end

  def update
    @event = Event.find(proposal_params[:event_id])
    @proposal = Proposal.find(params[:id])
    @performance = @proposal.performance
    @proposal.update(proposal_params)
    @confirmed_proposals = @event.proposals.confirmed
    if @performance.user == current_user
      respond_to do |format|
        format.js { render action: :status }
      end
    elsif @event.place.user == current_user
      respond_to do |format|
        format.js
      end
    end
  end

  private

  def set_proposal
    @proposal = Proposal.find(params[:id])
  end

  def proposal_params
    params.require(:proposal).permit(:status, :event_id)
  end
end
