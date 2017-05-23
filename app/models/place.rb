class Place < ApplicationRecord
  belongs_to :user
  has_many :events
  has_many :proposals, through: :events
  has_attachment :photo
  validates :name, presence: true
  validates :address, presence: true
  geocoded_by :address
  after_validation :geocode, if: :address_changed
end
