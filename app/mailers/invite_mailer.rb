class InviteMailer < ApplicationMailer
  def invite(invite_facade)
    @facade = invite_facade
    mail(to: invite_facade.invitee_email, subject: "#{invite_facade.current_user.github_name} has invited you to Brownfield.")
  end
end
