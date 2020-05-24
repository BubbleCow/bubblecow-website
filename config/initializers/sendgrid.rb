ActionMailer::Base.smtp_settings = {
  :user_name => 'apikey',
  :password => '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',
  :domain => 'services.bubblecow.com',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}