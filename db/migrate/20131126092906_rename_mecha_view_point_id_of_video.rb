class RenameMechaViewPointIdOfVideo < ActiveRecord::Migration
  def change
    rename_column :videos, :mecha_view_point_id, :mecha_viewpoint_id
  end
end
