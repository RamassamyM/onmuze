class Performance < ApplicationRecord
  belongs_to :user
  has_many :proposals
  has_many :events, through: :proposals
  validates :name, presence: true
  validates :address, presence: true
  validates :category, presence: true
end
