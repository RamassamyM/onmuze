class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :places
  has_many :events, through: :places
  has_many :proposals, through: :performances
  has_many :performances
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
