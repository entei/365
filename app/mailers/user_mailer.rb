class UserMailer < ActionMailer::Base
  default from: "noreply@my365days.com"
  
  def welcome_email(user)
     @user = user
     @url = user_session_url
     mail(to: user.email, subject: "Welcome to 365days calendar")
  end

  def invitation_email(email, user, event)
  	@user = user 
  	@url = new_user_registration_url
  	@event = event
  	mail(to: email, subject: "My365days calendar invitation")
  end
end
