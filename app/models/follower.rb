class Follower
  attr_reader :name, :url

  def initialize(follower_data)
    @name = follower_data[:login]
    @url  = follower_data[:html_url]
  end
end
