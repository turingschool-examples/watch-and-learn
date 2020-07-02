class Followers
  attr_reader :handle, :url
  def initialize(followers_data)
    @handle = followers_data[:handle]
    @url = followers_data[:url]
  end
end
