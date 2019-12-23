class CreateProductImages < ActiveRecord::Migration[6.0]
  def change
    create_table :product_images do |t|
    	t.attachment :product_image
    	t.references :product
      t.timestamps
    end
  end
end
