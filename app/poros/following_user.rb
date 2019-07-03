class FollowingUser
  attr_reader :handle, :url

  def initialize(user_data)
    @handle = user_data[:login]
    @url = user_data[:html_url]
  end
end
