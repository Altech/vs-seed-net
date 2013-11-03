class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :youtube_video_id, null: false
      t.references :event, index: true
      t.boolean :win_or_lose
      t.references :mecha_view_point, index: true
      t.references :mecha_consort, index: true
      t.references :mecha_enemy1, index: true
      t.references :mecha_enemy2, index: true
      t.references :player_viewpoint, index: true
      t.references :player_consort, index: true
      t.references :player_enemy1, index: true
      t.references :player_enemy2, index: true

      t.timestamps
    end
    add_index :videos, :youtube_video_id, unique: true
  end
end
