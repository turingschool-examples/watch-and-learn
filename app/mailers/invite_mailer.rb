class InviteMailer < ApplicationMailer

  def invite(user, github_user)
    @user = user
    mail(to: github_user, subject: "#{user.name} wants to invite you to Brownfield of Dreams.")
  end


end
