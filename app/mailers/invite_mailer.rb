
class InviteMailer < ApplicationMailer
  def invite(email, handle, invitee)
    @handle = handle
    @invitee = invitee
    mail(to: email, subject: 'User Invitation')
  end
end
