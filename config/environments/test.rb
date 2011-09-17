Calculator::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # The test environment is used exclusively to run your application's
  # test suite.  You never need to work with it otherwise.  Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs.  Don't rely on the data there!
  config.cache_classes = true

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment
  config.action_controller.allow_forgery_protection    = false

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  config.action_mailer.delivery_method = :test

  # Use SQL instead of Active Record's schema dumper when creating the test database.
  # This is necessary if your schema can't be completely dumped by the schema dumper,
  # like if you have constraints or database-specific column types
  # config.active_record.schema_format = :sql

  # Print deprecation notices to the stderr
  config.active_support.deprecation = :stderr
end


require "rubygems"
require "active_merchant"

 ActiveMerchant::Billing::Base.mode = :test

 gateway = ActiveMerchant::Billing::PaypalGateway.new(
    # API Credential
   :login => "phani._1314544877_biz_api1.gmail.com",
   :password => "1314544913",
   :signature => "AmFh3qxMDR3V5ghOL4LiUBr5248cA9kvHabuu.n2-z8ltJ2m9wef3dYs"
 )

 credit_card = ActiveMerchant::Billing::CreditCard.new(
   #user's credit card information
   :type               => "visa",
   :number             => "4105644566630043",
   :verification_value => "123",
   :month              => 1,
   :year               => 2013,
   :first_name         => "fatimah",
   :last_name          => "aeroneta"
 )

 if credit_card.valid?
   # or gateway.purchase to do both authorize and capture
   response = gateway.authorize(1000, credit_card, :ip => "127.0.0.1",:billing_address => {
     :name     => 'Test User',
     :company  => '',
     :address1 => '1 Main St',
     :address2 => '2 Main St',
     :city     => 'San Jose',
     :state    => 'CA',
     :country  => 'US',
     :zip      => '95131',
     :phone    => '408-678-0945'
     })
   if response.success?
      gateway.capture(1000, response.authorization)
     puts "Purchase complete!"
   else
     puts "Error: #{response.message}"
   end
 else
   puts "Error: credit card is not valid. #{credit_card.errors.full_messages.join('. ')}"
 end
