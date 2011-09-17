class CollegeController < ActionController::Base
  # before_filter :authenticate_user!
  before_filter :get_user_choice_collection
  layout "application"
  def index
  end
  def state_selected
    session[:state_id] = params["state"]["state_id"]
    @colleges = College.find_all_by_state_id(session[:state_id])
    @category_id = params[:category_id] || 1
  end

  def get_user_choice_collection
    @user_choice_collection = session[:user_choice_collection]  ||=  UserChoiceCollection.new([])
  end
end
