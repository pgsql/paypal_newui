class CreateContactUs < ActiveRecord::Migration
  def self.up
    create_table :contact_us do |t|
      t.string :name
      t.string :email
      t.string :company
      t.string :phone_number
      t.string :subject
      t.text :message

      t.timestamps
    end
  end

  def self.down
    drop_table :contact_us
  end
end
