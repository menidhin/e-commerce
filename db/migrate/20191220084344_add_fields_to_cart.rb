class AddFieldsToCart < ActiveRecord::Migration[6.0]
  def change
  	add_column :carts, :status, :string, :default => "Active"
  end
end
