class ChangeAmountToDecimalInPaymentOptions < ActiveRecord::Migration
  def self.up
    change_column :payment_options, :amount, :decimal, :precision => 16, :scale => 2
  end

  def self.down
    change_column :payment_options, :amount, :float
  end
end
