class ConfirmationNotifierMailer < ApplicationMailer
  def confirm(user)
    @user = user
    mail(to: user.email, subject: 'Confirm Email')
  end
end
