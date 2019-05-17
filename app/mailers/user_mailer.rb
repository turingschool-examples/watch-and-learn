class UserMailer < ActionMailer::Base
  default :from => "no-reply@brownfield.io"

  def registration_confirmation(user)
    @user = user
    mail(:to => "#{user.email}", :subject => "Registration Confirmation")
  end
end
