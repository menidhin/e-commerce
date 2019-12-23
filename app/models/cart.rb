class Cart < ApplicationRecord
	belongs_to :product
	belongs_to :user

	has_many :orders


 	scope :non_deleted, -> {
 		where.not(:status => 'deleted')
 	}

 	
 	def destroy
 		self.status = 'deleted'
 		self.save
 	end

end
