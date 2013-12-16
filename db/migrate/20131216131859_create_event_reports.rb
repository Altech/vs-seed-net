class CreateEventReports < ActiveRecord::Migration
  def change
    create_table :event_reports do |t|
      t.references :event, index: true
      t.text :body
      t.references :author, index: true

      t.timestamps
    end
  end
end
