class AddPilotIdToPlayer < ActiveRecord::Migration
  def change
    add_reference :players, :pilot, index: true
  end
end
