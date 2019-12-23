class OrdersController < ApplicationController

		before_action :authenticate_user!


	def index
		@orders = Order.non_deleted.paginate(:page => params[:page], :per_page => 5).order(:created_at => "ASC")
	end

	def my_orders
		@orders = Order.non_deleted.where(:user_id => current_user.id).paginate(:page => params[:page], :per_page => 5).order(:created_at => "ASC")
	end

	def new
		@order = Order.new
		@cart = Cart.find(params[:cart_id])

	end

	def create
		@product = Product.find(params[:order][:product_id])
		@order = Order.new(order_params)
		@order.user_id = current_user.id
		@order.product_id = params[:order][:product_id]
		@order.product_price = @product.price
		respond_to do |format|
			if @order.save

				format.html{ redirect_to "/my_orders", :notice => "Product Ordered successfully"}
			else
				format.html{ redirect_to "/carts", :notice => "Something went wrong, Please try again later iii."}
			end
		end			
	end


	def checkout
		@order = Order.new
		@carts = Cart.where(:user_id => current_user.id).non_deleted
	end

	def checkout_submit	
		@carts = Cart.where(:user_id => current_user.id).non_deleted
		  @carts.each do |cart|
				@order = Order.new(order_params_for_cart)
				@order.cart_id = cart.id
				@order.user_id = current_user.id
				@order.product_id = cart.product_id
				@order.product_price = cart.product.price
 				if @order.save
 					cart.status = 'deleted'
 					cart.save
					flash[:notice => "Product Ordered successfully"]
				else
					flash[:notice => "Error, Please try later"]
				end	
			end	
			redirect_to "/my_orders"
	end	

	def destroy
		@order = Order.find(params[:id])
		respond_to do |format|
			if @order.destroy
				format.html{ redirect_to orders_path, :notice => "Order cancelled successfully"}
			else
				format.html{ redirect_to orders_path, :notice => "error"}
			end
		end			
	end

	def cancelled
		@order = Order.find(params[:id])
		@order.status = "Cancelled"
		respond_to do |format|
			if @order.save
				if current_user.has_role?("admin")
					format.html{ redirect_to orders_path, :notice => "Status changed successfully"}
				else
					format.html{ redirect_to "/my_orders", :notice => "Order cancelled successfully."}
				end		
			else
				format.html{ redirect_to orders_path, :notice => "Something went wrong, Please try again later."}
			end
		end				
	end

	def delivered
		@order = Order.find(params[:id])
		@order.status = "Delivered"
		respond_to do |format|
			if @order.save
				format.html{ redirect_to orders_path, :notice => "Product delivered successfully"}				
			else
				format.html{ redirect_to orders_path, :notice => "Something went wrong, Please try again later."}
			end
		end				
	end

	def packed
		@order = Order.find(params[:id])
		@order.status = "Packed"
		respond_to do |format|
			if @order.save
				format.html{ redirect_to orders_path, :notce => "Product packed successfully"}
			else
				format.html{ redirect_to orders_path, :notice => " Something went wrong, Please try again later"}
			end
		end
	end
	
	def shipped
		@order = Order.find(params[:id])
		@order.status = "Shipped"
		respond_to do |format|
			if @order.save
				format.html{ redirect_to orders_path, :notice => "Product shipped successfully"}
			else	
				format.html{ redirect_to orders_path, :notice => "Something went wrong, Please try again later"}
			end		
		end				
	end

	private

		def order_params
			params.require(:order).permit(:name, :address, :phone_number, :quantity, :cart_id, :product_id)
		end

		def order_params_for_cart
			params.require(:order).permit(:name, :address, :phone_number)
		end
end