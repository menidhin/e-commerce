class Product < ApplicationRecord

	has_many :likes
	has_many :reviews
	has_many :carts
	has_many :orders
	has_many :product_images

	belongs_to :category

	has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  validates :name , presence: true
  validates :price, presence: true


end
