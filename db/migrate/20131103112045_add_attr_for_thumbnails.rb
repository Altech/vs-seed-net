class AddAttrForThumbnails < ActiveRecord::Migration
  def self.up
    add_attachment :videos, :thumbnail
  end

  def self.down
    remove_attachment :videos, :thumbnail
  end  
end
