class InvitationNotifierMailer < ApplicationMailer

  def invite(user, handle)

    invitee_info = GithubService.new.invitee_json(user, handle)
    user_info = GithubService.new.user_json(user)

    @invitee_name = invitee_info['login']
    @user_info = user_info['login']


    mail(to: invitee_info['email'], subject: "Brownfield-of-Dreams: Invitation") if invitee_info['email']

  end
end
