class UserFollowing
  attr_reader :handle, :url
  def initialize(following_data)
    @handle = following_data[:handle]
    @url = following_data[:url]
  end
end
