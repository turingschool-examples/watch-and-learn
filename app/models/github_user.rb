class GithubUser
  attr_reader :username,
              :github_url,
              :email

  def initialize(data)
    @username = data[:login]
    @github_url = data[:html_url]
    @email = data[:email]
  end

  def linked_github?
    !User.find_by(github_name: @username).nil?
  end

  def not_friend?(user_id)
    local_user = User.find_by(github_name: @username)
    user = User.find(user_id)
    friend_check = user.friends.where(followed_user_id: local_user.id)
    friend_check.count.zero?
  end
end
