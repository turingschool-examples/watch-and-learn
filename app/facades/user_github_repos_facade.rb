class UserGithubReposFacade

  def initialize(user)
    @user = user
  end

  def user_repos
    response = service.get_repos
    response.map do |repo_data|
      Repository.new(repo_data)
    end
  end

  def top_user_repos(quantity)
    user_repos[0,quantity]
  end

  def service
    GithubService.new(@user)
  end
end
