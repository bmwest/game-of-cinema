class AddUserIdToTheaters < ActiveRecord::Migration[5.0]
  def change
    add_column :theaters, :user_id, :integer, null: false
  end
end
