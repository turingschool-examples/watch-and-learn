class InviteMailer < ApplicationMailer
  def invite(user, invitee_login, invitee_email)
    @user = user
    @invitee_login = invitee_login
    @invitee_email = invitee_email
    mail(to: invitee_email, subject: 'Join Turing Video Tutorials')
  end
end
