# frozen_string_literal: true

class Rider < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  # has_one_attached :image
  has_one :wallet, as: :user, dependent: :destroy

  after_create :create_wallet

  def name
    "#{first_name} #{last_name}"
  end

  def create_wallet
    Wallet.create(
      user: self,
      amount: 0
    )
  end
end
