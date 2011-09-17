class GeneralController < ApplicationController
  skip_before_filter :authenticate_user!
  skip_before_filter :check_for_terms_acceptance
  skip_before_filter :check_for_access_period
  skip_before_filter :check_user_status


  def index
    if user_signed_in? 
      redirect_to surveys_path
    end
  end  

  def contact
    @contact = ContactUs.new
  end

  def save_contact
    @contact = ContactUs.new(params[:contact_us])
    @contact.subject = params[:subject]
     respond_to do |format|
      if @contact.save
        UserMailer.contact_confirmation(@contact).deliver
        flash[:notice] = "Thanks for contact us. We will contact you soon."
        format.html {redirect_to(contact_url, :notice => 'Thanks for contact us. We will contact you soon.') }
      else
        format.html { render :action => "contact" }
      end
 
     
    end

   
  end

  def aboutus
  end

end
