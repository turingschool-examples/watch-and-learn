# frozen_string_literal: true

class Invite
  def initialize(invitee, current_user)
    service = GithubService.new(current_user)
    @inviter = current_user
    @invitee = service.user(invitee)
  end

  def send
    if @invitee[:email]
      UserNotifierMailer.invite(@invitee, @inviter).deliver_now
      true
    else
      false
    end
  end
end
