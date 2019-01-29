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
    generate_github_users(service.followers)
  end

  def following
    generate_github_users(service.following)
  end

  def service
    GithubService.new(@github_key)
  end

  private

  def generate_github_users(json)
    json.map do |attributes|
      GithubUser.new(attributes)
    end
  end
end
