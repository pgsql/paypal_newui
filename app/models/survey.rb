class Survey < ActiveRecord::Base
  belongs_to :loan_option

  validates_presence_of :money_contribute_to_college
  validates_presence_of :something_for_vacation
  validates_presence_of :expense_for_child
  validates_presence_of :monthly_paid_off
  validates_presence_of :something_for_vacation
  validates_presence_of :save_after_child_to_college
  validates_presence_of :money_save_for_college
  validates_presence_of :willing_for_pay_college
  validates_presence_of :loan_option_id

  def calculate_result
    self.result = adjusted_gross_income.to_f + after_adjusted_gross_input.to_f
    self.result += (money_contribute_to_college.to_f * 12)
    self.result += (expense_for_child.to_f * 12)
    self.result += (monthly_paid_off.to_f * 12)
    self.result += (something_for_vacation.to_f * 12)
    self.result += (save_after_child_to_college.to_f * 12)
    self.result += (money_save_for_college.to_f / 4 )
    self.result += (willing_for_pay_college.to_f / 4 )
    self.result += loan_option_amount
  end

  def loan_option_amount
    if loan_option.respond_to?(:amount)
      return (loan_option.amount.to_f / 4)
    else
      return 0
    end
  end

end
