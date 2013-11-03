class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :held_at, null: false
      t.string :location, null: false
      t.string :youtube_playlist_id

      t.timestamps
    end
    add_index :events, :youtube_playlist_id, unique: true
  end
end
