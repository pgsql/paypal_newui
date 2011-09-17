class CreateColleges < ActiveRecord::Migration
  def self.up
    create_table :colleges do |t|
      t.string :name, :url
      t.integer :state_id
      t.integer :category_id
      t.timestamps
    end
    add_index :colleges , :state_id
    add_index :colleges , :category_id
  end

  def self.down
    drop_table :colleges
  end
end
