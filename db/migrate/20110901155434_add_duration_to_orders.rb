class AddDurationToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :duration, :integer
  end

  def self.down
    remove_column :orders, :duration
  end
end
