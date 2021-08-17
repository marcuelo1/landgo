class Category < ApplicationRecord
    has_many :category_deals
    # category image
    has_one_attached :image
    
    enum status: {"New" => 0, "Public but closed" => 1, "Public" => 2}
end
