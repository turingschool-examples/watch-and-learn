class ActivateMailer < ApplicationMailer
  def activate(user)
    @user = user
    mail(to: @user.email, subject: 'Visit here to activate your account.')
  end
end
