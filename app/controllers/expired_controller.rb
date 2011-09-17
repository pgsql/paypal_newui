class ExpiredController < ApplicationController
  skip_before_filter :check_for_terms_acceptance
  skip_before_filter :check_for_access_period
  
  def index
    
  end

end
