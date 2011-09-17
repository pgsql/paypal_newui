class CreatePaymentOptions < ActiveRecord::Migration
  def self.up
    create_table :payment_options do |t|
      t.string :name
      t.integer :duration
      t.float :amount

      t.timestamps
    end
  end

  def self.down
    drop_table :payment_options
  end
end
