class RepositoriesFacade

  def initialize(attributes)
    @quantity = attributes[:quantity] || 0
  end

  def repositories
    response = service.get_repos(@quantity)
    response.map do |repo_data|
      Repository.new(repo_data)
    end
  end

  def service
    GithubService.new
  end

end
