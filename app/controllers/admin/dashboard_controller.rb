class Admin::DashboardController < ApplicationController
  before_filter "require_login"
  before_filter "admin_user?"
  layout "admin"
  
  def index
  end
end
