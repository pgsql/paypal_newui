ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "66.135.33.230:6666",
  :user_name            => "mfftest.ranjit@gmail.com",
  :password             => "#123mff$",
  :authentication       => "plain",
  :enable_starttls_auto => true
}


ActionMailer::Base.default_url_options[:host] = "66.135.33.230:6666"
