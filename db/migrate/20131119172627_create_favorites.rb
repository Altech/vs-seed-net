class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.references :video
      t.references :player

      t.timestamps
    end
  end
end
