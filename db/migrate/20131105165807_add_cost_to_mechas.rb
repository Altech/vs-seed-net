class AddCostToMechas < ActiveRecord::Migration
  def change
    add_column :mechas, :cost, :integer
  end
end
