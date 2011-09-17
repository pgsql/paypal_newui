class CreateSurveys < ActiveRecord::Migration
  def self.up
    create_table :surveys do |t|
      t.float :adjusted_gross_income
      t.float :after_adjusted_gross_input
      t.float :tax_credit
      t.float :money_contribute_to_college
      t.float :expense_for_child
      t.float :monthly_paid_off
      t.float :something_for_vacation
      t.float :save_after_child_to_college
      t.float :money_save_for_college
      t.float :willing_for_pay_college
      t.float :result
      t.integer :loan_option_id

      t.timestamps
    end
    add_index :surveys, :loan_option_id
  end

  def self.down
    drop_table :surveys
  end
end
