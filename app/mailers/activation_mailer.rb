# frozen_string_literal: true

class ActivationMailer < ApplicationMailer
  def activate(user)
    @activation_token = user.activation_token
    sender = 'BrownfieldOfDreams@gmail.com'
    subject = 'Activate Your Account Here'
    mail(to: user.email, from: sender, subject: subject)
  end
end
