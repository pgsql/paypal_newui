ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "66.228.51.151:3000",
  :user_name            => "mfftest.ranjit@gmail.com",
  :password             => "#123mff$",
  :authentication       => "plain",
  :enable_starttls_auto => true
}


ActionMailer::Base.default_url_options[:host] = "66.228.51.151:3000"
