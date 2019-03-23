class InviteMailer < ApplicationMailer

  def invite(user, recipient)
    recipient = GithubService.new(user).get_user(recipient)
    @invite = InviteFacade.new(user, recipient)
    mail(to: @invite.to_address, subject: "Someone's Invited You!")
  end
end
