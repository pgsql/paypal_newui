class AddRoleIdToUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :category_id
    add_column :users, :role_id, :integer
    add_index :users, :role_id
  end

  def self.down
    remove_column :users, :role_id
  end
end
