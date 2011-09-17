class Admin::PaymentOptionsController < ApplicationController
  before_filter "require_login"
  before_filter "admin_user?"
  layout "admin"
  
  def index
    @payment_options = PaymentOption.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @payment_options }
    end
  end

  # GET /categories/1
  # GET /categories/1.xml
  def show
    @payment_option = PaymentOption.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @payment_option }
    end
  end

  # GET /categories/new
  # GET /categories/new.xml
  def new
    @payment_option = PaymentOption.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @payment_option }
    end
  end

  # GET /categories/1/edit
  def edit
    @payment_option = PaymentOption.find(params[:id])
  end

  # POST /categories
  # POST /categories.xml
  def create
    @payment_option = PaymentOption.new(params[:payment_option])

    respond_to do |format|
      if @payment_option.save
        format.html {redirect_to([:admin, @payment_option], :notice => 'Payment Option was successfully created.') }
        format.xml  { render :xml => @payment_option, :status => :created, :location => @payment_option }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @payment_option.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /categories/1
  # PUT /categories/1.xml
  def update
    @payment_option = PaymentOption.find(params[:id])

    respond_to do |format|
      if @payment_option.update_attributes(params[:payment_option])
        format.html { redirect_to([:admin, @payment_option], :notice => 'PaymentOption was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @payment_option.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.xml
  def destroy
    @payment_option = PaymentOption.find(params[:id])
    @payment_option.destroy

    respond_to do |format|
      format.html { redirect_to([:admin, @payment_option]) }
      format.xml  { head :ok }
    end
  end
end
