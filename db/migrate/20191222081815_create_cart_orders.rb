class CreateCartOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :cart_orders do |t|
    	t.references :cart
    	t.references :order
    	t.string :price
    	t.string :status, :default => "Active"
      t.timestamps
    end
  end
end
