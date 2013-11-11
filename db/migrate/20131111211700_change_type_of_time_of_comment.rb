class ChangeTypeOfTimeOfComment < ActiveRecord::Migration
  def change
    change_column :comments, :time, :float
  end
end
