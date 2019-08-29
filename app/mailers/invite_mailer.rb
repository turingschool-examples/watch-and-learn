class InviteMailer < ApplicationMailer
  def invite(email, handle, inviter)
    @handle = handle
    @inviter = inviter
    mail(to: email, subject: 'User Invitation')
  end
end
