class ProposalsController < ApplicationController
  before_action :set_proposal, only: %i(show)

  def index
    @proposals = current_user.proposals
  end

  def show; end

  def create
    @performance = Performance.find(params[:performance_id])
    @proposal = @performance.proposals.new(status: "pending", event_id: proposal_params[:event_id])
    if @proposal.save
      @event = @proposal.event
      redirect_to event_path(@event)
    else
      @event = Event.new
      render 'performances/show'
    end
  end

  def update
    @event = Event.find(proposal_params[:event_id])
    @proposal = Proposal.find(params[:id])
    @proposal.update(proposal_params)
    @confirmed_proposals = @event.proposals.where(status: 'confirmed')
  end

  private

  def set_proposal
    @proposal = Proposal.find(params[:id])
  end

  def proposal_params
    params.require(:proposal).permit(:id, :status, :event_id)
  end
end

