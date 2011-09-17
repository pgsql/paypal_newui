class AddValueToCoupons < ActiveRecord::Migration
  def self.up
    add_column :coupons, :value, :integer
  end

  def self.down
    remove_column :coupons, :value
  end
end