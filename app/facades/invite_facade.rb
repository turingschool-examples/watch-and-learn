class InviteFacade
  attr_reader :current_user, :invitee_email, :invitee_name
  def initialize(user, path)
    @current_user = user
    @service = InviteService.new(user.token, path)
    @invitee_email = nil
    @invitee_name = nil
    invitee_json
  end

  def invitee_json
    invitee = @service.retrieve_invitee
    @invitee_email = invitee[:email]
    @invitee_name = invitee[:name]
  end
end
