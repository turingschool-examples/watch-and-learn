class Follower
  attr_reader :name, :url

  def initialize(follower)
    @name = follower[:login]
    @url = follower[:html_url]
  end
end
