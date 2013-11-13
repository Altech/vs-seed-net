class AddPasswordAndMailToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :mail, :string
    add_column :players, :password_digest, :string
  end
end
