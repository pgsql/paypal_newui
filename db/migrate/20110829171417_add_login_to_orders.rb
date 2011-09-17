class AddLoginToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :login, :string
  end

  def self.down
    remove_column :orders, :login
  end
end
