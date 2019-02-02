class GithubInviterMailer < ApplicationMailer
  def invite(user, invitee)
    @user = user
    @invitee = invitee
    mail(to: invitee.email, subject: "#{user.first_name}, #{user.last_name} has invited to join Brownfield of Dreams")
  end
end
