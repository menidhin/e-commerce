class AddFieldsToOrder < ActiveRecord::Migration[6.0]
  def change
  	add_reference :orders, :user
  end
end
