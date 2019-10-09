class UserGithubFacade

  def initialize(token)
    @token = token
  end

  def repos
    service = GithubService.new(@token)
    @repos ||= service.get_repos.map do |repo_data|
      Repo.new(repo_data)
    end
  end
end
