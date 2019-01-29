class GithubFacade
  def initialize(github_key)
    @github_key = github_key
  end

  def owned_repos
    repos = service.owned_repos
    repos.map do |raw_repo|
      Repo.new(raw_repo)
    end
  end

  def service
    GithubService.new(@github_key)
  end
end
