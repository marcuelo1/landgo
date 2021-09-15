# frozen_string_literal: true

class Buyer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :carts
  has_many :locations, as: :user, dependent: :destroy

  after_create :create_current_location

  def selected_location
    loc = self.locations.where(selected: true).first

    return loc ? loc.id : 0
  end

  def create_current_location
    Location.create(
      user: self,
      name: "Current Location",
      selected: true
    )
  end
end
