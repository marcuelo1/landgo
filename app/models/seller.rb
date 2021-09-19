# frozen_string_literal: true

class Seller < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  belongs_to :category
  has_one_attached :image
  has_many :product_categories
  has_many :products
  has_many :product_sizes
  has_many :add_on_groups
  has_many :add_ons, through: :add_on_groups
  has_one :location, as: :user, dependent: :destroy
  has_many :checkout_sellers, dependent: :destroy

  DISTANCE = 5

  def rating
    4.8
  end

  def self.top_sellers
    Seller.all.order(num_of_completed_checkouts: :desc).limit(10)
  end

  def self.all_sellers buyer
    buyer_coordinates = [buyer.selected_location.latitude, buyer.selected_location.longitude]
    seller_ids = Location.where(user_type: "Seller").near(buyer_coordinates, DISTANCE, units: :km).map{|l| l.user_id}
    Seller.find(seller_ids)
  end
  
end
