class InviteMailer < ApplicationMailer

  def invite(user, recipient)
    email = GithubService.new.get_email(recipient)
  end
end
