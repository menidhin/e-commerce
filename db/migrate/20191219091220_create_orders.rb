class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
    	t.string :name, null: false
    	t.text :address, null: false
    	t.string :phone_number, null: false
    	t.string :quantity, :default => 1
    	t.string :status, :default => "Ordered"
    	t.references :cart
      t.timestamps
    end
  end
end
