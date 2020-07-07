class Following
  attr_reader :login, :url, :user_id, :uid
  def initialize(login, url, uid)
    @login = login
    @url = url
    @uid = uid
    @user_id = find_user
  end

  def friendable
    if User.find_by(uid: @uid)
      true
    else
      false
    end
  end

  def find_user
    if friendable
      user = User.find_by(uid: @uid)
      user.id
    end
  end
end
