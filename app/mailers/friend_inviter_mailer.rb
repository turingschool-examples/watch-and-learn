class FriendInviterMailer < ApplicationMailer
  def create(user_email, their_github, my_github)
    @their_github = their_github
    @my_github = my_github
    mail(to: user_email, subject: "You're invited")
  end
end
