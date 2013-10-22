class UserMailer < ActionMailer::Base
  default from: "from@example.com"
  
  def welcome_email(user)
     @user = user
     @url = user_session_url
     mail(to: user.email, subject: "Welcome to 365days calendar")
  end
end
