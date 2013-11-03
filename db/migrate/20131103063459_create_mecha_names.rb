class CreateMechaNames < ActiveRecord::Migration
  def change
    create_table :mecha_names do |t|
      t.string :name, null: false
      t.references :mecha, index: true

      t.timestamps
    end
    add_index :mecha_names, :name, unique: true
  end
end
