class Follower
  attr_reader :login,
              :url
  def initialize(follower_data)
    @login = follower_data[:login]
    @url = follower_data[:html_url]
  end

end
