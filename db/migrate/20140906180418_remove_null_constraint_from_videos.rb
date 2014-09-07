class RemoveNullConstraintFromVideos < ActiveRecord::Migration
  def change
    change_column :videos, :youtube_video_id, :string, :null => true
  end
end
