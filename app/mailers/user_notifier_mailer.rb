class UserNotifierMailer < ApplicationMailer
  def inform(user, user_email)
    @user = user
    mail(to: user_email, subject: "Please Activate Your Jamesfield Account")
  end

  def invite(invitee, inviter)
    @invitee = invitee
    @inviter = inviter
    mail(to: invitee[:email], subject: "Invitation to Join Turing Tutorials")
  end
end
