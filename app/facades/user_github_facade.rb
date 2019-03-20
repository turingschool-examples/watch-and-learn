class UserGithubFacade
  def initialize(user)
    @user = user
  end

  def user_repos
    response = service.get_user_repos(@user)
    response.map do |repo_data|
      Repo.new(repo_data)
    end
  end

  def user_followers
    response = service.get_user_followers(@user)
    response.map do |follower_data|
      Follower.new(follower_data)
    end
  end

  def service
    GithubService.new
  end
end
