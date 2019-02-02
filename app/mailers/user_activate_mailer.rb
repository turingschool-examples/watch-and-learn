class UserActivateMailer < ApplicationMailer

  def activate(user, server)
    @user = user
    @server = server
    mail(to: user[:email], subject: "Please Activate Your Account!")
  end

end
