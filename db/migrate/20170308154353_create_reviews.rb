class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.string :body, null:false
      t.integer :user_id, null:false
      t.integer :theater_id, null:false
    end
  end
end
