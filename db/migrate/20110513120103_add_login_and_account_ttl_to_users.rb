class AddLoginAndAccountTtlToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :login, :string, :limit => 80
    add_column :users, :access_until, :date
    
    add_index  :users, :login, :unique => true
  end

  def self.down
    remove_column :users, :access_until
    remove_column :users, :login
  end
end
