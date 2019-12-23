class CartsController < ApplicationController

	before_action :authenticate_user!


	def index
		@carts = Cart.where(:user_id => current_user.id).non_deleted
	end

	def create
		@cart = Cart.where(:product_id => params[:product_id], :user_id => current_user.id ).non_deleted.first
		
		if @cart.present?
			@cart.quantity += 1
		else
			@cart = Cart.new()
			@cart.user_id = current_user.id
			@cart.product_id = params[:product_id]	
		end	

		if @cart.save
			redirect_to products_path, :notice => "Product added into cart successfully"
		else
			redirect_to products_path, :notice => "Something went wrong, Please try again later"
		end
	end

	def destroy
		@cart = Cart.find(params[:id])
		if @cart.destroy
			redirect_to carts_path, :notice => "Product removed from cart successfully"
		else	
			redirect_to carts_path, :notice => "Something went wrong, Please try again later"
		end	
	end	

	def buy_now
		@cart = Cart.new()
		@cart.user_id = current_user.id
		@cart.product_id = params[:product_id]
		if @cart.save
			redirect_to  checkout_path
		else
			redirect_to products_path, :notice => "Something went wrong, Please try again later"
		end
	end	

end		