class CreateLoanOptions < ActiveRecord::Migration
  def self.up
    create_table :loan_options do |t|
      t.string :name
      t.string :range
      t.float :amount

      t.timestamps
    end
  end

  def self.down
    drop_table :loan_options
  end
end
