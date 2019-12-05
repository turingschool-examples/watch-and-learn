class Follower
  attr_reader :login, :html_url

  def initialize(login, html_url)
    @login = login
    @html_url = html_url
  end
end
