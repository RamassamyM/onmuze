class Proposal < ApplicationRecord
  belongs_to :performance
  belongs_to :event
  validates :status, presence: true
end
