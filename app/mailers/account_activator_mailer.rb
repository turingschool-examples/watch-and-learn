class AccountActivatorMailer < ApplicationMailer
  def activation(user)
    @new_user = user
    mail(to: user.email, subject: "Turing Tutorials Account Activation")
  end
end
