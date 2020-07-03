class Following
  attr_reader :login, :url
  def initialize(login, url)
    @login = login
    @url = url
  end
end
