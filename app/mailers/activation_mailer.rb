class ActivationMailer < ApplicationMailer
  def activation(user)
    @user = user
    mail(to: @user.email, subject: "BROWNFIELD OF DREAMS Account Activation")
  end
end
