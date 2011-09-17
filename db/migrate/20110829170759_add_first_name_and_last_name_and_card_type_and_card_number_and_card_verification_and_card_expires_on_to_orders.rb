class AddFirstNameAndLastNameAndCardTypeAndCardNumberAndCardVerificationAndCardExpiresOnToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :card_number, :string
    add_column :orders, :card_verification, :string
    add_column :orders, :card_exires_on, :string
  end

  def self.down
    remove_column :orders, :card_exires_on
    remove_column :orders, :card_verification
    remove_column :orders, :card_number
  end
end
