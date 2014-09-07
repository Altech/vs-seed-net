class AddNicoVideoIdToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :nico_video_id, :string
  end
end
