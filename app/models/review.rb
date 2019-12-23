class Review < ApplicationRecord
	belongs_to :user
	belongs_to :product

	validates :review_body, presence: true
end
