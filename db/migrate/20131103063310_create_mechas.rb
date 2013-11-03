class CreateMechas < ActiveRecord::Migration
  def change
    create_table :mechas do |t|
      t.references :full_name, index: true, null: false
      t.references :nickname, index: true, null: false

      t.timestamps
    end
  end
end
