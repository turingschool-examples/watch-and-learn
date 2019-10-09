class Follower
  attr_reader :user_name, :html_url

  def initialize(hash)
    @user_name = hash[:login]
    @html_url = hash[:html_url]
  end
end
