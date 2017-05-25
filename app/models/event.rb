class Event < ApplicationRecord
  belongs_to :place
  has_many :proposals
  has_many :performances, through: :proposals
  has_attachment :photo
  validates :scheduled_at, presence: true
  validates :place_id, presence: true
end
