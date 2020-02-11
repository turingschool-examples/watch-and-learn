class Following
  attr_reader :name, :url
  def initialize(data)
    @name = data[:login]
    @url = data[:html_url]
    @u_id = data[:id]
  end

  def user_exists(follower)
  end
end
