class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :name
      t.boolean :in_state
      t.integer :type_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :categories
  end
end
