class UserDashboardFacade
  def initialize(token)
    @token = token
  end

  def repos(limit)
    repos = github_service.find_repositories
    repo_objects = repos.map do |repo|
      Repository.new(repo)
    end
    repo_objects.take(limit)
  end

  private

  def github_service
    GithubService.new(@token)
  end
end
