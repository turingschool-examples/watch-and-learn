class Follower
  attr_reader :login, :html_url, :id

  def initialize(attrs = {})
    @login = attrs[:login]
    @html_url = attrs[:html_url]
    @id = attrs[:id]
  end
end
