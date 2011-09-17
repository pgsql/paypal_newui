class SurveysController < ApplicationController

  skip_before_filter  :check_user_status, :only => [:new]

  # GET /surveys
  # GET /surveys.xml
  def index
    redirect_to new_survey_path
  end

  # GET /surveys/1
  # GET /surveys/1.xml
#  def show
#    @result = session[:result]
#
#    respond_to do |format|
#      format.html # show.html.erb
#      format.xml  { render :xml => @survey }
#    end

  def result
    @result = session[:result]

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @survey }
    end
  end


  # GET /surveys/new
  # GET /surveys/new.xml
  def new
    @survey = Survey.new(:loan_option_id => 0)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @survey }
    end
  end

  # GET /surveys/1/edit
#  def edit
#    @survey = Survey.find(params[:id])
#  end

  # POST /surveys
  # POST /surveys.xml
  def create
    @survey = Survey.new(params[:survey])

    respond_to do |format|
      if @survey.valid? and @survey.calculate_result
        session[:result] = @survey.result
        format.html { redirect_to("/surveys/result", :notice => 'surveys was successfully created.') }
        format.xml  { render :xml => @survey, :status => :created, :location => @survey }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @survey.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /surveys/1
  # PUT /surveys/1.xml
#  def update
#    @survey = Survey.find(params[:id])
#
#    respond_to do |format|
#      if @survey.update_attributes(params[:survey])
#        format.html { redirect_to(@survey, :notice => 'surveys was successfully updated.') }
#        format.xml  { head :ok }
#      else
#        format.html { render :action => "edit" }
#        format.xml  { render :xml => @survey.errors, :status => :unprocessable_entity }
#      end
#    end
#  end

  # DELETE /surveys/1
  # DELETE /surveys/1.xml
#  def destroy
#    @survey = Survey.find(params[:id])
#    @survey.destroy
#
#    respond_to do |format|
#      format.html { redirect_to(survey_index_url) }
#      format.xml  { head :ok }
#    end
#  end
end
