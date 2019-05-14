class Follower
  attr_reader :handle, :url, :git_id
  def initialize(data)
    @handle = data[:login]
    @url  = data[:html_url]
    @git_id = data[:id]
  end

  def not_friend_or_user?
    if !follower_a_registered_user || Friendship.find_by(friended_user_id: follower_a_registered_user.id)
      false
    else
      true
    end
  end

  def follower_a_registered_user
    User.find_by(github_id: @git_id)
  end
end
