class Genre < ApplicationRecord
  has_many :performances
  validates :event_type, presence: true
  validates :name, presence: true
end
