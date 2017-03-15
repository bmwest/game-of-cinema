class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.integer :review_id
      t.integer :user_id
      t.string :value
    end
  end
end
