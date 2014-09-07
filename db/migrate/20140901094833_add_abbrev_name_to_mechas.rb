class AddAbbrevNameToMechas < ActiveRecord::Migration
  def change
    add_reference :mechas, :abbrev_name, index: true
  end
end
