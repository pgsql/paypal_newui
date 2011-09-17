class AddMessageAndTransactionIdToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :message, :string
    add_column :orders, :tran, :string
  end

  def self.down
    remove_column :orders, :tran
    remove_column :orders, :message
  end
end
