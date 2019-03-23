class InviteFacade

  def initialize(sender, recipient)
    @sender = sender
    @recipient = recipient
  end

  def to_address
    @recipient[:email]
  end

  def to_username
    @recipient[:name]
  end

  def from_username
    @sender.first_name + " " + @sender.last_name
  end
end
