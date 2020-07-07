class Follower
  attr_reader :login, :url
  def initialize(login, url, uid)
    @login = login
    @url = url
    @uid = uid
  end

  def friendable

    if User.find_by(uid: @uid)
      true
    else
      false
    end
  end
end
