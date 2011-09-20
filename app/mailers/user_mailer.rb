class UserMailer < ActionMailer::Base
  default :from => "fpalmas@yahoo.com"

  def contact_confirmation(contact)
    @contact = contact
    mail(:to => "fpalmas@yahoo.com", :subject => "ContactUs", :from => contact.email )
  end

  # send password reset instructions
  def reset_password_instructions(user)
    @resource = user
    mail(:to => @resource.email, :subject => "Reset password instructions", :tag => 'password-reset', :content_type => "text/html") do |format|
      format.html { render "devise/mailer/reset_password_instructions" }
    end
  end

  def payment_confirmation(order)
    @subject = "[#{'Payment Confirmation'} Do Not Reply] Payment Success!."
    @user = order.user
    @order = order
    mail(:to => "phani.rubyonrails@gmail.com", :subject => subject)
    headers["X-SMTPAPI"] = '{"category": "Payment confimration message"}'
  end

  def order_failure_confirmation(order)
    @subject = "[#{'Payment Confirmation'} Do Not Reply] Payment Failed!."
    @user = order.user
    @order = order
    mail(:to => "phani.rubyonrails@gmail.com", :subject => subject)
    headers["X-SMTPAPI"] = '{"category": "Payment confimration message"}'
  end
end
