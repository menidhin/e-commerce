class ProductsController < ApplicationController

	before_action :set_product, only: [:show, :edit, :update, :destroy]

	def index
		if params[:select_category].present?
			@products = Product.where(:category_id => params[:select_category]).paginate(:page => params[:page], :per_page => 6).order(:created_at => "ASC")
		else
		  @products = Product.paginate(:page => params[:page], :per_page => 6).order(:created_at => "ASC")
		end
		@categories = Category.all
		@likes = Like.all
	end

	def show
		@review = Review.new
		@reviews = Review.includes(:user).where(:product_id => @product.id).paginate(:page => params[:page], :per_page => 3).order(:created_at => "ASC")
	end

	def new
		@product = Product.new
	end

	def edit
		
	end

	def create
		@product = Product.new(product_params)
		respond_to do |format|
			if @product.save
				format.html{ redirect_to products_path, :notice => "Product has been created successfully."}
			else
				format.html{ render :new}	
			end
		end
	end
	
	def update
		respond_to do |format|
			if @product.update(product_params)
				format.html{ redirect_to products_path, :notice => "Product has been updated successfully."}
			else
				format.html{ render :edit}
			end			
		end
	end
	
	def destroy
		respond_to do |format|
			if @product.destroy
				format.html{ redirect_to products_path, :notice => "Product has been deleted successfully."}
			else
				format.html{ redirect_to products_path, :notice => "There was an error, Please try again later."}	
			end			
		end
	end

	def search
		if params[:search].blank?  
    	redirect_to(products_path, alert: "Empty field!") and return  
  	else  
    	@parameter = params[:search].downcase  
			@results = Product.all.where("lower(name) LIKE :search", search: "%#{@parameter}%")  	
		end  
	end

	private

		def set_product 
			@product = Product.find(params[:id]) if params[:id]		
		end

		def product_params
			params.require(:product).permit(:name, :price, :description, :image, :category_id	)		
		end		
	end