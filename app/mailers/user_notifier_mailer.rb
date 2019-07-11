class UserNotifierMailer < ApplicationMailer
  def inform(user, user_email)
    @user = user
    mail(to: user_email, subject: "Please Activate Your Jamesfield Account")
  end
end
