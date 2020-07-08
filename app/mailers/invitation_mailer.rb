class InvitationMailer < ApplicationMailer
  def invite(invited, inviter, recipient)
    @invited = invited
    @inviter = inviter
    mail(to: recipient, subject: "You've been invited to join!")
  end
end
