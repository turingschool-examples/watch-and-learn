class UserActivateMailer < ApplicationMailer

  def activate(email)
    mail(to: email, subject: "Please Activate Your Account!")
  end

end
