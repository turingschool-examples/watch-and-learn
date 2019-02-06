class AccountInviteMailer < ApplicationMailer
  def invite(invitation)
    @invitee_name = invitation.invitee_name
    @inviter_name = invitation.inviter_name
    mail(to: invitation.invitee_email, subject: "#{@inviter_name} invites you to the Turing Tutorials App.")
  end
end
