class UserMailer < ApplicationMailer
  def registration_email(user)
    @user = user
    mail(to: user.email, subject: "Activate your Account")
  end
end
