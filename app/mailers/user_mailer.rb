class UserMailer < ActionMailer::Base
  default from: 'no-reply@brownfield.com'

  def registration_confirmation(user)
    @user = user
    mail(:to => "#{user.first_name} <#{user.email}>", :subject => "Thanks for signing up! Please confirm your registration.")
  end
end
