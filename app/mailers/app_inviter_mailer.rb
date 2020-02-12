class AppInviterMailer < ApplicationMailer
  def invite(user, gh_handle, invitee_email)
    @user = user
    @gh_handle = gh_handle
    mail( to: invitee_email, subject: 'Invite to join Brownfield of Dreams')
  end
end
