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

  def rating
    4.8
  end

  def self.top_sellers
    Seller.all
  end

  def self.recent_sellers
    Seller.all
  end

  def self.all_sellers
    Seller.all
  end
  
end
