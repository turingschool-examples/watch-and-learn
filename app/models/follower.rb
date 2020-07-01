class Follower
  attr_reader :login, :link
  def initialize(follower_data)
    @login = follower_data[:login]
    @link = follower_data[:html_url]
  end
end
