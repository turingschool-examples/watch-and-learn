class UserMailer < ApplicationMailer

  def activate_account(user)
    @user = user
    mail(to: user.email, subject: "Activate your Account")
  end

end
