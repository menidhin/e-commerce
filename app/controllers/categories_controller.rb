class CategoriesController < ApplicationController

	before_action :set_category, only: [:show, :edit, :update, :destroy]


	def index
		@categories = Category.paginate( page: params[:page], per_page: 3)
	end	

	def new
		@category = Category.new
	end	

	def show
	end

	def edit
	end	

	def create
		@category = Category.new(category_params)
		respond_to do |format|
			if @category.save
				format.html { redirect_to category_path(@category), notice:"successfully created" }
			else
				format.html { render :new }
			end	
		end	
	end

	def update
		respond_to do |format|
			if @category.update(category_params)
				format.html { redirect_to category_path(@category), notice: "successfully updated" }
			else
				format.html { render :new }
			end	
		end
	end	

	def destroy
		@category.destroy
		respond_to do |format|
			format.html { redirect_to categories_path(@category), notice: "successfully deleted"}
			format.json { head :no_content }
		end
	end			

	private

		def set_category
				@category ||= Category.find(params[:id]) if params[:id]
		end

		def category_params
			params.require(:category).permit( :name)
		end	

end	