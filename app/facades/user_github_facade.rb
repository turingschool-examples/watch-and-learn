class UserGithubFacade

  def initialize(token)
    @token = token
  end

  def service
    GithubService.new(@token)
  end

  def repos
    service.get_repos.map do |repo_data|
      Repo.new(repo_data)
    end.first(5)
  end

  def followers
    service.get_followers.map do |repo_data|
      GithubUser.new(repo_data)
    end
  end

  def following
    service.get_following.map do |repo_data|
      GithubUser.new(repo_data)
    end
  end
end
