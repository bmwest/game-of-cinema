class AddImageToTheaters < ActiveRecord::Migration[5.0]
  def change
    add_column :theaters, :image, :string
  end
end
