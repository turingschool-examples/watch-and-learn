class GithubFacade
  def initialize(user)
    @user = user
  end

  def repos
    response = service.get_repos
    response.map do |repo|
      Repo.new(repo)
    end.take(5)
  end

  def service
    GithubService.new(@user.github_token)
  end
end
