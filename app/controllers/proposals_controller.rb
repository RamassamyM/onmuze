class ProposalsController < ApplicationController
  before_action :set_proposal, only: %i(show)

  def index
    @proposals = current_user.proposals
  end

  def show; end

  def update
    # byebug
    @event = Event.find(proposal_params[:event_id])
    @proposal = Proposal.find(params[:id])
    @proposal.update(proposal_params)
    @confirmed_proposals = @event.proposals.confirmed
  end

  private

  def set_proposal
    @proposal = Proposal.find(params[:id])
  end

  def proposal_params
    params.require(:proposal).permit(:status, :event_id)
  end
end
