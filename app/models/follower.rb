class Follower
  attr_reader :handle,
              :html_url

  def initialize(follower_data)
    @handle = follower_data[:login]
    @html_url = follower_data[:html_url]
  end
end
