class Follower
  attr_reader :handle,
              :url,
              :uid

  def initialize(follower)
    @handle = follower[:login]
    @url = follower[:html_url]
    @uid = follower[:id].to_s
  end
end
