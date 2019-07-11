class Invite

  def initialize(invitee, current_user)
    service = GithubService.new(current_user)
    @inviter = service.user
    @invitee = service.user(invitee)
  end

  def send
    if @invitee[:email]
      UserNotifierMailer.invite(@invitee, @inviter)
      true
    else
      false
    end
  end
end
