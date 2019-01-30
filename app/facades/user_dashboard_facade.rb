class UserDashboardFacade
  def initialize(user)
    @user = user
  end

  def user_repos(count)
    repo_list[0...count]
  end

  def user_followers
    follower_list
  end

  def user_followings
    following_list
  end

  private

  def following_list
     service.following
  end

  def follower_list
    service.followers
  end

  def repo_list
     service.repositories
  end

  def service
    GithubService.new(@user.github_token)
  end
end
