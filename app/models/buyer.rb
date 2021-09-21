# frozen_string_literal: true

class Buyer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :carts
  has_many :locations, as: :user, dependent: :destroy
  has_many :checkouts, dependent: :destroy
  has_many :checkout_sellers, through: :checkouts
  has_many :buyer_payment_methods, dependent: :destroy

  after_create :create_current_location

  def selected_location
    self.locations.where(selected: true).first
  end

  def create_current_location
    Location.create(
      user: self,
      name: "Current Location",
      selected: true
    )
  end

  def current_loc
    self.locations.where(name: "Current Location").first
  end

  def name
    "#{first_name} #{last_name}"
  end
  
  def recent_sellers
    seller_ids = self.checkout_sellers.where('checkout_sellers.created_at > ?', 1.weeks.ago).order(created_at: :desc).pluck(:seller_id)

    Seller.where(id: seller_ids)
  end

  def selected_payment_method
    self.buyer_payment_methods.where(selected: true).first
  end
end
