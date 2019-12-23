class LikesController < ApplicationController

before_action :authenticate_user!


	def create 
		@like = Like.new()
		@like.user_id = current_user.id 
		@like.product_id = params[:product_id]
		if check_already_liked?
			redirect_to product_path(@like.product_id), :notice => "Already liked!, You can't likes more than once."
		else @like.save
			redirect_to product_path(@like.product_id), :notice => "Product liked successfully."					
		end	
	end
					
	private
		def check_already_liked?
			Like.where(:user_id => current_user.id, :product_id => params[:product_id]).exists?
		end	
end	