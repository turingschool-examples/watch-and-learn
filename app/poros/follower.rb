class Follower
  attr_reader :name, :link

  def initialize(follower_data)
    @name = follower_data[:login]
    @link = follower_data[:html_url]
  end
end
