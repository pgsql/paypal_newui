class AdminController < ApplicationController
  
  before_filter :check_for_admin
  skip_before_filter :check_for_access_period
  
  def check_for_admin
    admin_user?
  end


end
