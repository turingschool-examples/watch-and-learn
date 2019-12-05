class Follower
  attr_reader :handle, :link
  
  def initialize(follower_hash)
    @handle = follower_hash[:login]
    @link = follower_hash[:html_url]
  end
end
