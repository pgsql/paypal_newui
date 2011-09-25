class OrdersController < ApplicationController
  # GET /orders
  # GET /orders.xml
  skip_before_filter :check_for_terms_acceptance, :only => [:new,:create,:sucess,:failure,:calculate_amount,:coupons_form]
  skip_before_filter :check_for_access_period, :only => [:new,:create,:sucess,:failure,:calculate_amount,:coupons_form]

  skip_before_filter :check_user_status, :only => [:new,:create,:sucess,:failure,:calculate_amount,:coupons_form]
#  skip_before_filter :check_for_access_period
  layout "sessions"
  
  def index
    @orders = Order.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.xml
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.xml
  def new
    @order = Order.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  # POST /orders
  # POST /orders.xml
  def create
    params[:order][:amount] = params[:amount]
    params[:order][:duration] = params[:duration]
    @order = Order.new(params[:order])
    params[:order][:name] = params[:order][:first_name] + " " + params[:order][:last_name] unless params[:order].blank?
    Rails.logger.info params.inspect
    @order.user = current_user
    host = request.instance_variable_get(:@env)["HTTP_HOST"]

    respond_to do |format|
       if @order.save
         session[:order] = @order.id
        if @order.purchase
          UserMailer.payment_confirmation(@order,host).deliver
          session[:order] = @order.id
          format.html { render :action => "success"}
        else
          UserMailer.order_failure_confirmation(@order,host).deliver
          format.html { render :action => "failure"}
        end
      else
        format.html { render :action => "new" }
      end
    end
  end

  def sucess
  end

  def failure
    
  end

  def calculate_amount
    session[:coupon] = ""
    session[:duration_price] = ""
    session[:duration_price] = ""
    session[:actual_price] = ""
    path_url = new_order_path
    session[:duration_price] = params["duration"]
    session[:actual_price] = params["duration"]
    session[:duration] = PaymentOption.find_by_amount(session[:duration_price]).name
    session[:duration_months] = PaymentOption.find_by_amount(session[:duration_price]).duration
    unless params["coupon"].blank?
      @coupon = Coupon.find_by_code(params["coupon"])
      if @coupon
        session[:coupon] = @coupon.value
        session[:duration_price] = params["duration"].to_f - params["duration"].to_f  * @coupon.value.to_f/100
        if session[:duration_price] == 0
          current_user.update_attributes({:status => "active",:access_until => Date.today.next_month(session[:duration_months])})
          path_url = "/welcome"
        end
      end
    end

    redirect_to path_url
  end

  def coupons_form

  end


#  def create
#    @order = current_cart.build_order(params[:order])
#    @order.ip_address = request.remote_ip
#    if @order.save
#      if @order.purchase
#        render :action => "success"
#      else
#        render :action => "failure"
#      end
#    else
#      render :action => 'new'
#    end
#  end

  # PUT /orders/1
  # PUT /orders/1.xml
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to(@order, :notice => 'Order was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.xml
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to(orders_url) }
      format.xml  { head :ok }
    end
  end

  def sign_up
    @order = Order.new
  end



end
