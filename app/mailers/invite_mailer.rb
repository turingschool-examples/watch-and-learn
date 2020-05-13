class InviteMailer < ApplicationMailer
  def inform(email_info, invitee_email)
    @inviter = email_info[:inviter]
    @invitee = email_info[:invitee]
    mail(to: invitee_email, subject: "#{@inviter} is inviting you to join their app!")
  end
end