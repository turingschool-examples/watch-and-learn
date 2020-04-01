class Follower
  attr_reader :login, :html_url

  def initialize(attributes = {})
    @login = attributes[:login]
    @html_url = attributes[:html_url]
  end

  def friendable?(current_user)
    return false if current_user.friends.pluck(:github_username).include?(login)

    User.exists?(github_username: login)
  end

end
