class EmailConfirmationMailer < ApplicationMailer
  def inform(recipient, message)
    mail(to: recipient, body: message)
  end
end
