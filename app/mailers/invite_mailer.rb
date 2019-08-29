
class InviteMailer < ApplicationMailer
  def invite(email, handle, invitee)
    @handle = handle
    @inviter = inviter
    mail(to: email, subject: 'User Invitation')
  end
end
