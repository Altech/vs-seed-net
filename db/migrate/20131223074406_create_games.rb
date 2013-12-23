class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.references :event, index: true
      t.integer :index_of_event
      t.references :a1_video, index: true, null: false
      t.references :a2_video, index: true
      t.references :b1_video, index: true
      t.references :b2_video, index: true

      t.timestamps
    end
    add_attachment :games, :thumbnail

    Video.all.each do |video|
      Game.create(event_id: video.event_id,
                  index_of_event: video.index_of_event,
                  a1_video_id: video.id,
                  thumbnail_file_name: video.thumbnail_file_name,
                  thumbnail_content_type: video.thumbnail_content_type,
                  thumbnail_file_size: video.thumbnail_file_size,
                  thumbnail_updated_at: video.thumbnail_updated_at)
    end

    rename_column :videos, :mecha_viewpoint_id, :mecha_id
    rename_column :videos, :player_viewpoint_id, :player_id

    remove_column :videos, :event_id
    remove_column :videos, :index_of_event
    remove_column :videos, :mecha_consort_id
    remove_column :videos, :mecha_enemy1_id
    remove_column :videos, :mecha_enemy2_id
    remove_column :videos, :player_consort_id
    remove_column :videos, :player_enemy1_id
    remove_column :videos, :player_enemy2_id
    remove_attachment :videos, :thumbnail
  end
end
