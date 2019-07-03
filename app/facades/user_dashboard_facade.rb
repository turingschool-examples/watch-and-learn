class UserDashboardFacade

  def initialize(user)
    @user = user
  end

  def repos
    repo_data = github_service.repos
    repo_data.map do |repo|
      Repo.new(repo)
    end
  end

  private
  attr_reader :user

  def github_service
    GithubService.new(user)
  end

end
