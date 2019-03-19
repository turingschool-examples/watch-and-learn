class DashboardFacade

  def initialize(attributes)
    @quantity = attributes[:quantity] || 0
  end

  def repositories
    response = service.get_repos(@quantity)
    response.map do |repo_data|
      Repository.new(repo_data)
    end
  end

  def followers
    response = service.get_followers
    response.map do |follower_data|
      Follower.new(follower_data)
    end
  end

  def service
    GithubService.new
  end

end
