class Category < ApplicationRecord
    enum status: {"New" => 0, "Public but closed" => 1, "Public" => 2}
end
