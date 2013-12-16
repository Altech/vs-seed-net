class RemovePlayerIdFromComments < ActiveRecord::Migration
  def change
    remove_column :comments, :player_id, :integer
  end
end
