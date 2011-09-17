class AddPasswordToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :password, :string
  end

  def self.down
    remove_column :orders, :password
  end
end
