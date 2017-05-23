class Event < ApplicationRecord
  belongs_to :place
  validates :scheduled_at, presence: true
end
