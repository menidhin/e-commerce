class ReviewsController < ApplicationController

	before_action :authenticate_user!


	def new
		@review = Review.new
	end

	def create
		@review = Review.new(review_params)
		@review.user_id = current_user.id
		@review.product_id = params[:product_id]
		respond_to do |format|
			if @review.save
				format.html{ redirect_to product_path(@review.product_id), notice: "Review created successfully." }
			else
				format.html{ redirect_to product_path(@review.product_id), notice => "Something went wrong, Please try again later" }
			end	
		end	 
	end

	private

		def review_params
			params.require(:review).permit(:product_id, :user_id, :review_body)
		end	
end
