class Follower
  attr_reader :handle,
              :url

  def initialize(follower)
    @handle = follower[:login]
    @url = follower[:html_url]
  end
end
