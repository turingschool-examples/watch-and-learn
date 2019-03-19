class DashboardFacade
  def initialize(user)
    @user = user
    @github = GithubService.new(@user)
  end

  def repositories
    @repositories ||= @github.user_repositories[0..4].map do |repository_info|
      Repository.new(repository_info)
    end
  end

  def followers
    @followers ||= @github.user_followers.map do |follower_info|
      GithubUser.new(follower_info)
    end
  end
end
