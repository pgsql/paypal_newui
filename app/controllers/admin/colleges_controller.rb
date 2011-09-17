class Admin::CollegesController < ApplicationController
  # GET /colleges
  # GET /colleges.xml

  before_filter "require_login"
  before_filter "admin_user?"
  layout "admin"

  def index
    @colleges = College.order(:name).paginate(:page => params[:page], :per_page => 40)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @colleges }
    end
  end

  # GET /colleges/1
  # GET /colleges/1.xml
  def show
    @college = College.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @college }
    end
  end

  # GET /colleges/new
  # GET /colleges/new.xml
  def new
    @college = College.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @college }
    end
  end

  # GET /colleges/1/edit
  def edit
    @college = College.find(params[:id])
  end

  # POST /colleges
  # POST /colleges.xml
  def create
    @college = College.new(params[:college])

    respond_to do |format|
      if @college.save
        format.html { redirect_to(admin_college_url(@college), :notice => 'College was successfully created.') }
        format.xml  { render :xml => @college, :status => :created, :location => @college }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @college.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /colleges/1
  # PUT /colleges/1.xml
  def update
    @college = College.unscoped.find(params[:id])

    respond_to do |format|
      if @college.update_attributes(params[:college])
        format.html { redirect_to(admin_college_url(@college), :notice => 'College was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @college.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /colleges/1
  # DELETE /colleges/1.xml
  def destroy
    @college = College.find(params[:id])
    @college.destroy

    respond_to do |format|
      format.html { redirect_to(admin_colleges_url) }
      format.xml  { head :ok }
    end
  end
  
  
  # GET /admin/colleges/import
  def import
    #@skip = params[:skip] || false
    @colsep = params[:colsep] || ','
    
    if params[:upload]
      data = params[:upload][:datafile]

      @lines_count = 0
      @colleges = { :new => [], :updated => [], :errors => [] }
      
      begin
        data.open.each do |line|
          
          logger.info "%%% #{line}"
          
          @lines_count += 1
          college_type_constant, college_name, college_state_name, college_url = line.split(@colsep).map{ |a| a.gsub(/^\"|\"?$/, '').strip }
          
          state = State.find_by_name(college_state_name)
          if state
            state_id = state.id
          else
            state_id = nil
          end
          
          category_id = begin
            Category.find_by_type_id(college_type_constant.constantize).id
          rescue 
            nil
          end
          
          
          college = College.unscoped.find_by_name_and_category_id_and_state_id college_name, category_id, state_id
          
          if college
            unless college.url == college_url
              college.update_attribute :url, college_url  
              @colleges[:updated] << college
            end
          else
            c = College.create(:name => college_name,
                               :state_id => state_id,
                               :url => college_url,
                               :category_id => category_id)
            if c.errors.empty?
              @colleges[:new]
            else
              @colleges[:errors]
            end << c  
          end
        end
        
        logger.info '---------------'
        logger.info "Lines: #{@lines_count}"
        logger.info @colleges
        logger.info '---------------'
        
      rescue
        @global_error = true
        logger.info "Something went wrong"
      end
    end
    
  end
end
