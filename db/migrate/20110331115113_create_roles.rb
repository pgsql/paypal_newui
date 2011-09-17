class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string :name
    end
    Role.create(
      [
        { :name => "admin" },
        { :name => "member" },
      ]
    )
  end

  def self.down
    drop_table :roles
  end
end
