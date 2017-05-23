class ProposalsController < ApplicationController
  before_action :set_proposal, only: %i(show)

  def index
    @proposals = current_user.proposals
  end

  def show; end

  private

  def set_proposal
    @proposal = Proposal.find(params[:id])
  end

  def proposal_params
    params.require(:proposal).permit(:event_id, :performance_id, :status)
  end
end
