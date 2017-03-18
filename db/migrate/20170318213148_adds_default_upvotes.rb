class AddsDefaultUpvotes < ActiveRecord::Migration[5.0]
  def up
    change_column :reviews, :upvotes, :integer, default: 0
    change_column :reviews, :downvotes, :integer, default: 0
  end

  def down
    change_column :reviews, :upvotes, :integer, default: nil
    change_column :reviews, :downvotes, :integer, default: nil
  end
end
