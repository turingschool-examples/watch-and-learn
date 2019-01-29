class GithubFacade
  def initialize(github_key)
    @github_key = github_key
  end

  def owned_repos(num)
    repos = []
    service.owned_repos.each_with_index do |raw_repo, i|
      repos << Repo.new(raw_repo)
      break if i == num
    end
    repos
  end

  def service
    GithubService.new(@github_key)
  end
end
