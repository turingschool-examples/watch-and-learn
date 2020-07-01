class Follower
  attr_reader :id, :login, :html_url

  def initialize(parsed_resp)
    @id = parsed_resp[:id]
    @login = parsed_resp[:login]
    @html_url = parsed_resp[:html_url]
  end
end
