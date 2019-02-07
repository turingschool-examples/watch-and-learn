class ConfirmationNotifierMailer < ApplicationMailer
  def confirm(user)
    @user = user
    @user.update(confirmation: SecureRandom.hex(15))
    mail(to: user.email, subject: 'Confirm Email')
  end
end
