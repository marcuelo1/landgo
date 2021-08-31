class Cart < ApplicationRecord
  belongs_to :buyer
  belongs_to :product
  belongs_to :seller
  belongs_to :product_price

  has_many :cart_add_ons, dependent: :destroy

  def product_description
    size_name = self.product_price.product_size.name
    add_on_names = self.cart_add_ons.map{|cao| cao.add_on.name}.join(", ")

    if self.cart_add_ons.count > 0
      size_name + ", " + add_on_names
    else
      size_name
    end
  end
  
end
