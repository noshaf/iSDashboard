# Load the rails application
require File.expand_path('../application', __FILE__)

ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.sendgrid.net',
  :port           => '587',
  :authentication => :plain,
  :user_name      => 'app16614032@heroku.com',
  :password       => 'dozw0hck',
  :domain         => 'heroku.com',
  :enable_starttls_auto => true
}

# Initialize the rails application
InstaStubClientScrapper::Application.initialize!
