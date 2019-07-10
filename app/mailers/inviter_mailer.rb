class InviterMailer < ApplicationMailer
  def invite(inviter, invitee_name, invitee_email)
    @inviter = inviter
    @invitee_name = invitee_name
    mail(to: invitee_email, subject: "#{@inviter.first_name} says join our app!")
  end
end
