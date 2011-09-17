class PaymentOption < ActiveRecord::Base
  validates_presence_of :name
  validates_numericality_of :duration
  validates_presence_of :amount
end