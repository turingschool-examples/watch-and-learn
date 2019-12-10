class ActivationMailer < ApplicationMailer
  def activate(user)
    mail(to: user.email,
         subject: "#{user.first_name} please activate your account.")
  end
end
