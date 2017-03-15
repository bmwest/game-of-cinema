class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.integer :rating, null: false
      t.string :body
      t.integer :user_id, null: false
      t.integer :theater_id, null: false
      t.integer :upvotes
      t.integer :downvotes
    end
  end
end
