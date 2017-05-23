class Performance < ApplicationRecord
  belongs_to :user
  has_many :proposals
  has_many :events, through: :proposals
  has_attachment :avatar
  has_attachment :banner
  validates :name, presence: true
  validates :address, presence: true
  validates :category, presence: true
end
