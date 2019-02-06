class GithubInvitationFacade

  def initialize(token, invitee_handle)
    @access_token = token
    @invitee_handle = invitee_handle
  end

  def invitation
    Invitation.new(invitee_name: find_invitee[:name],
                  invitee_email: find_invitee[:email],
                  inviter_name: find_inviter[:name])
  end

  private

  def find_invitee
    @_invitee ||= service.invitee(@invitee_handle)
  end

  def find_inviter
    @_inviter ||= service.inviter(@invitee_handle)
  end

  def service
    GithubService.new(@access_token)
  end
end
