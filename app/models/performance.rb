class Performance < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_many :proposals
  has_many :events, through: :proposals
  has_attachment :avatar
  has_attachment :banner
  validates :name, presence: true
  validates :address, presence: true
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
end
