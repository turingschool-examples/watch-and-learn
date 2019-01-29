class GithubFacade
  def initialize(github_key)
    @github_key = github_key
  end

  def owned_repos(num=5)
    repos = []
    service.owned_repos.each_with_index do |raw_repo, i|
      repos << Repo.new(raw_repo)
      break if i == num - 1
    end
    repos
  end

  def followers
    service.followers.map do |raw_follower|
      Follower.new(raw_follower)
    end
  end

  def service
    GithubService.new(@github_key)
  end
end
