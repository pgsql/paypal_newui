class CollegeChoicesController < ApplicationController
  before_filter :get_user_choice_collection
  def show
    @state_id = session[:state_id] || 1
    @state = State.find( @state_id )
  end

  def create
    choice_array = CollegeChoice.create_multiple_from_params(params)
    choice_array.each {|choice| @user_choice_collection.add_choice(choice)}
    redirect_to :action => :show
  end

  def new
    #TODO put in handling for if no params are selected- that would be a BIG list.
    @state_id = params[:state_id].blank? ? nil : params[:state_id].to_i
    @category_id = params[:category_id].blank? ? nil : params[:category_id].to_i
    @outside_state_id = params[:outside_state_id].blank? ? nil : params[:outside_state_id].to_i
    @category = Category.find(@category_id)
    colleges = College.by_optional_category_id(@category_id).order(:name)
    @states = State.build_college_hash(colleges).sort
  end

  def update
    @user_choice_collection.update_attributes(params[:user_choice_collection])
    session[:user_choice_collection] = @user_choice_collection
    redirect_to :action => :show
  end

  def get_user_choice_collection
    @user_choice_collection = session[:user_choice_collection]  ||=  UserChoiceCollection.new([])
  end
end
