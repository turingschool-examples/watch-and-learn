class DashboardFacade

  def initialize(attributes, current_user = nil)
    @quantity = attributes[:quantity] || 0
    @current_user = current_user
  end

  def repositories
    response = service.get_repos(@quantity, @current_user)
    response.map do |repo_data|
      Repository.new(repo_data)
    end
  end

  def followers
    response = service.get_followers(@current_user)
    response.map do |follower_data|
      GithubUser.new(follower_data)
    end
  end

  def following
    response = service.get_following(@current_user)
    response.map do |following_data|
      GithubUser.new(following_data)
    end
  end

  def service
    GithubService.new
  end

end
