class ApplicationController < ActionController::Base
  
  before_filter :authenticate_user!
  before_filter :check_for_access_period, :unless => lambda { |c| c.controller_name == 'sessions' || c.controller_name == 'registrations' || c.controller_name == 'passwords' || c.controller_name == 'general'}
  before_filter :check_for_terms_acceptance, :unless => lambda { |c| c.controller_name == 'sessions' || c.controller_name == 'registrations' || c.controller_name == 'passwords' || c.controller_name == 'general'}
  before_filter :check_user_status,:unless => lambda { |c| c.controller_name == 'sessions' || c.controller_name == 'registrations' || c.controller_name == 'passwords'|| c.controller_name == 'general'}
  protect_from_forgery
  def require_login
    if current_user.nil?
      flash[:error] = "you don't have access"
      redirect_to "/users/sign_in"
    else
      return current_user
    end
  end

  def check_user_status
    if current_user && !current_user.admin? && current_user.status != "active"
      redirect_to coupons_form_orders_path
    end
  end
  
  #def after_sign_in_path_for(resource)
  #  welcome_url
  #end

  def check_for_access_period
    if user_signed_in? && current_user.access_until && current_user.access_until < Date.current && current_user.role.nil?
      redirect_to expired_path, :notice => "Expired account"
    end
  end
  
  def check_for_terms_acceptance
    if (session[:terms_accepted] != true && current_user.role.nil?) 
      redirect_to welcome_path
    end
  end

  def admin_user?
    if current_user and current_user.role.nil?
      flash[:error] = "you don't have access"
      redirect_to surveys_path
    end
  end

  def index
  end

  def about
  end

  def tour
  end

  def pricing
  end

  def contact
  end
end
