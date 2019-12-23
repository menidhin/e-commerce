class ProductImagesController < ApplicationController
	

	def new
		@product_image = ProductImage.new
	end

	def create
		@product_image = ProductImage.new(product_image_params)
		respond_to do |format|
			if @product_image.save
				format.html { redirect_to product_path(@product_image.product_id), notice: "successfully created" }
			else
				format.html { render :new }
			end	
		end	 
	end

	def destroy
		@product_image = ProductImage.find(params[:id])
		@product = @product_image.product_id
		respond_to do |format|
		  if @product_image.destroy
				format.html { redirect_to product_path(@product), notice: "successfully deleted" }
			else
				format.html{ redirect_to product_path(@product)}
			end		
		end	
	end

	private

		def product_image_params
			params.require(:product_image).permit(:product_id, :product_image)
		end	
end
