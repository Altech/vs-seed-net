class AddMemoToFavorites < ActiveRecord::Migration
  def change
    add_column :favorites, :memo, :string
  end
end
