class AddDescriptionAndAmountAndStatusToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :description, :string
    add_column :orders, :amount, :float
    add_column :orders, :status, :string
  end

  def self.down
    remove_column :orders, :status
    remove_column :orders, :amount
    remove_column :orders, :description
  end
end
