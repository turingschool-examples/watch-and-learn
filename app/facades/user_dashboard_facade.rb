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

  private

  def follower_list
    @follower_list ||= service.followers
  end

  def repo_list
    @repo_list ||= service.repositories
  end

  def service
    GithubService.new(@user.github_token)
  end
end
