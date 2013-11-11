class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :video, :null => false
      t.integer :time, :null => false
      t.string :text, :null => false
      t.references :player

      t.timestamps
    end
  end
end
