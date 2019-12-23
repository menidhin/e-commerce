class CartOrder < ApplicationRecord
	has_many :orders
	belongs_to :carts
end
