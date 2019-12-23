class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
    	t.integer :number_of_stars, :default => 0
    	t.text :review_body
    	t.references :product
    	t.references :user 
      t.timestamps
    end
  end
end
