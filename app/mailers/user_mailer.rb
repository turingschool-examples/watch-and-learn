class UserMailer < ApplicationMailer
  def registration_email(user, url)
    @user = user
    @url = url
    mail(to: user.email, subject: "Activate your Account")
  end

  def registration_email(user, url)
    @user = user
    @url = url
    mail(to: user.email, subject: "Activate your Account")
  end
end
