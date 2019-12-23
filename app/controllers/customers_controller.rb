class CustomersController < ApplicationController

	before_action :set_customer, :only => [:show, :edit, :update, :destroy, :home]

  before_action :only_for_admin, :only => [:index]

	def index
		@customers = User.all
	end

	def show

	end

	def home

	end

	def new
		@customer = User.new
	end

	def edit
		@customer = current_user
	end

	def create
		@customer = User.new(customer_params)
		respond_to do |format|
			if @customer.save
				if user_signed_in?
					if current_user.has_role?("admin") 
						format.html{ redirect_to customers_path, :notice => "Customer has been created successfully."}
					end	
				else
					format.html{ redirect_to new_user_session_path}	
				end	
			else	
				format.html{ render :new}
			end
		end	
	end

	def update
		if @customer.update(customer_params)
			#if user_signed_in?
				#if current_user.has_role?("admin") 
					#redirect_to customers_path, :notice => "Customer has been updated successfully."
				#else
					redirect_to "/", :notice => "Updated successfully" 
				#end		
			#end
		else		
		  render :edit
		end
	end

	def destroy
		respond_to do |format|
			if @customer.destroy
				format.html{ redirect_to customers_path, :notice => "Customer has bbe deleted successfully."}
			else
				format.html{ redirect_to customers_path, :notice => "Error, Try again later."}
			end
		end			
	end

	private

		def set_customer
			@customer ||= User.find(params[:id]) if params[:id]
		end

		def customer_params
			params.require(:user).permit(:name, :email, :password, :status, :mobile_number, :address, :age)
		end

    def only_for_admin
      unless current_user.has_role?("admin")
        redirect_to "/" , :notice => "Access Denied" 
       end
    end    

end		