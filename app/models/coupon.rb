class Coupon < ActiveRecord::Base
   
  validates_presence_of :name
  validates_presence_of :code
  validates_presence_of :value
end
