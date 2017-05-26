class Proposal < ApplicationRecord
  belongs_to :performance
  belongs_to :event
  validates :status, presence: true
  validates :event_id, presence: true
  enum status: %i(pending accepted confirmed declined archived)
end
