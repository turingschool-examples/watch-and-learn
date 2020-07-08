class UserActivationMailer < ApplicationMailer
  def activate(user)
    @user = user
    mail(to: user.email, subject: "Activating #{user.first_name}'s account")
  end
end
