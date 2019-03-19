class DashboardRepoFacade

  def initialize(user_token)
    @user_token = user_token
  end

  def repos
    response = service.get_repos(@user_token)
    response.map do |repo|
      Repo.new(repo)
    end
  end

  def service
    GithubService.new
  end

end
