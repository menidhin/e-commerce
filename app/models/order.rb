class Order < ApplicationRecord

	belongs_to :cart
  belongs_to :product

	validates :name, presence: true
	validates :address, presence: true
	validates :phone_number, presence: true

 	scope :non_deleted, -> {
 		where.not(:status => 'deleted')
 	}

 	def destroy
 		self.status = 'deleted'
 		self.save
 	end

end


