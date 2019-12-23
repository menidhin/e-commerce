class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price
      t.text :description
      t.attachment :image
      t.references :user

      t.timestamps
    end
  end
end
