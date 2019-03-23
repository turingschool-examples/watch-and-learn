class InviteMailer < ApplicationMailer

  def invite(user, recipient)
    recipient = GithubService.new.get_user(recipient)
    @invite = InviteFacade.new(user, recipient
    mail(to: @invite.to_address, subject: "Someone's Invited You!").send_now
  end
end
