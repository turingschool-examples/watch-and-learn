class Follower
  attr_reader :login,
              :html_url

  def initialize(attributes)
    @login = attributes[:login]
    @html_url = attributes[:html_url]
  end

  def id
    User.find_by(handle: @login).id
  end

  def not_already_a_friend_of(user)
    follower = User.find_by(handle: @login)
    !user.friends.include?(follower)
  end

end