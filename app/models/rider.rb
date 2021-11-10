# frozen_string_literal: true

class Rider < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  # has_one_attached :image
  has_one :wallet, as: :user, dependent: :destroy
  has_one :location, as: :user, dependent: :destroy
  has_many :checkout_sellers
  has_many :rider_transactions
  belongs_to :batch

  after_create :create_wallet

  enum status: {"Not Logged In" => 0, "On Shift" => 1, "Off Shift" => 2, "On Break" => 3, "On Deliver" => 4, "Pending Order" => 5}

  def name
    "#{first_name} #{last_name}"
  end

  def create_wallet
    Wallet.create(
      user: self,
      amount: 0
    )
  end

  def status_int
    Rider.statuses[self.status]
  end

  def current_checkout_seller
    self.checkout_sellers.where.not(status: "Completed").first
  end

  def self.broadcast
    ActionCable.server.broadcast("transaction", { body: "This Room is Best Room." })
  end
end
