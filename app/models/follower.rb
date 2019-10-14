class Follower
  attr_reader :name, :url, :uid

  def initialize(follower)
    @name = follower[:login]
    @url = follower[:html_url]
    @uid = follower[:id]
  end
end
