class AccountActivatorMailer < ApplicationMailer
  def activation(user)
    @user = user
    mail(to: user.email, subject: "Turing Tutorials Account Activation")
  end
end
