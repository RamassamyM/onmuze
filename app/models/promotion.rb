class Promotion < ApplicationRecord
  belongs_to :event
  validates :name, :message, :eventpage_url, presence: true
end
