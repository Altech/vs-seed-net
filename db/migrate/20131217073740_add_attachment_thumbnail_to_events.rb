class AddAttachmentThumbnailToEvents < ActiveRecord::Migration
  def self.up
    change_table :events do |t|
      t.attachment :thumbnail
    end
  end

  def self.down
    drop_attached_file :events, :thumbnail
  end
end
