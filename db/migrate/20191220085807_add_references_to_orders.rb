class AddReferencesToOrders < ActiveRecord::Migration[6.0]
  def change
  	add_reference :orders, :product
  	add_column :orders, :product_price, :decimal
  end
end
