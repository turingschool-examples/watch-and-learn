class Follower
  attr_reader :login, :url

  def initialize(attributes = {})
    @login = attributes[:login]
    @url = attributes[:url]
  end
end
