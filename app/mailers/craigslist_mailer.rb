class CraigslistMailer < ActionMailer::Base
  default from: "InstaStub@instastub.com"

  def test_email(email)
    mail(:to => email, :subject => "Welcome to InstaStub!")
  end
end
