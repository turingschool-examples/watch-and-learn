class EmailConfirmationMailer < ApplicationMailer
  def inform(recipient)
    email = recipient.email
    mail(to: email, subject: "confirm email", body: "Visit here to activate your account.")
  end
end
