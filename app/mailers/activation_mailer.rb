class ActivationMailer < ApplicationMailer
  def activate_user(user)
    @user = user
    mail(to: user.email, subject: 'Link to activate your account.')
  end
end
