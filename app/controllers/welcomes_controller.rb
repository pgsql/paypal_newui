class WelcomesController < ApplicationController
  skip_before_filter :check_for_terms_acceptance
  skip_before_filter :check_for_access_period

  def show
    
  end

  def create
    if params[:accepted] && params[:accepted] == "1"
      session[:terms_accepted] = true
      redirect_to new_survey_url
    else
      flash[:notice] = "You need to agree to the terms below before proceeding"
      render :action => :show
    end
  end
end
