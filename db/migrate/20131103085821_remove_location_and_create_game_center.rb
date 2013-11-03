class RemoveLocationAndCreateGameCenter < ActiveRecord::Migration
  def change
    create_table :game_centers do |t|
      t.string :station, null: false
      t.string :name, null: false
      t.string :location, null: false
    end
    # location = station + name (for performance)
    add_index :game_centers, :location, unique: true
    
    change_table :events do |t|
      t.remove :location
      t.references :game_center
    end
  end
end
