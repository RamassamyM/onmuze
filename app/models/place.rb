class Place < ApplicationRecord
  belongs_to :user
  has_many :events
  validates :name, presence: true
  validates :address, presence: true
end
