class CreateCoupons < ActiveRecord::Migration
  def self.up
    create_table :coupons do |t|
      t.string :name
      t.string :code
      t.integer :max_users
      t.date :validity

      t.timestamps
    end
  end

  def self.down
    drop_table :coupons
  end
end
