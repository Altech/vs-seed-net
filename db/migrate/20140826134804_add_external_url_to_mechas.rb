class AddExternalUrlToMechas < ActiveRecord::Migration
  def change
    add_column :mechas, :external_url, :string
  end
end
