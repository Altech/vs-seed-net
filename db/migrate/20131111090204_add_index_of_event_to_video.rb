class AddIndexOfEventToVideo < ActiveRecord::Migration
  def change
    add_column :videos,:index_of_event, :integer
  end
end
