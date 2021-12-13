# frozen_string_literal: true

class Seller < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  belongs_to :category
  has_one_attached :image
  has_one :schedule
  has_many :checkout_sellers, dependent: :destroy
  has_many :seller_transactions, dependent: :destroy

  has_many :record_trackers, dependent: :destroy
  has_many :discount_trackers, dependent: :destroy

  has_many :product_categories, dependent: :destroy
  has_many :products, dependent: :destroy
  
  has_many :product_template_aogs, dependent: :destroy
  has_many :add_on_groups, dependent: :destroy
  has_many :add_ons, through: :add_on_groups

  ### PG SEARCH
  include PgSearch::Model
  multisearchable against: [:name], update_if: :name_changed?
  pg_search_scope(
    :seller_search, 
    against: [:name], 
    associated_against: {
      products: [:name, :description]
    },
    using: {
      tsearch: { prefix: true }
    }
  )

  ### GEOCODE
  reverse_geocoded_by :latitude, :longitude

  DISTANCE = 5
  RATE_PER_KM = 10

  def address 
    [details, street, village, city.present? ? city + " City" : "", state].compact.join(", ") 
  end 

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

  def buyer_delivery_fee buyer
    # get distance between seller and buyer
    seller = self
    return 10
  end
  
  def self.transfer_loc_to_seller
    Location.where(user_type: "Seller").each do |l|
      seller = Seller.find(l.user_id)
      seller.longitude = l.longitude
      seller.latitude = l.latitude
      seller.details = l.details
      seller.street = l.street
      seller.city = l.city
      seller.village = l.village
      seller.state = l.state

      seller.save
    end
  end
end
