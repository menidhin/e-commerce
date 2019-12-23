class AddAgePhoneNumberToCustomer < ActiveRecord::Migration[6.0]
  def change
  	add_column :users, :mobile_number, :string
  	add_column :users, :age, :integer
  	add_column :users, :address, :text
  end
end
