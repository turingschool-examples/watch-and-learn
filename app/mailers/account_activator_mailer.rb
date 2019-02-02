class AccountActivatorMailer < ApplicationMailer
  def activation_request(user)
    @user = user
    mail(to: user.email, subject: "Activate")
  end
end
