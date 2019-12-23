class AddQuantityToCart < ActiveRecord::Migration[6.0]
  def change
  	add_column :carts, :quantity, :decimal, :default => 1 
  end
end
