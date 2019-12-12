class Invitee
  attr_reader :login, :email

  def initialize(attributes)
    @login = attributes[:login]
    @email = attributes[:email]
  end
end
