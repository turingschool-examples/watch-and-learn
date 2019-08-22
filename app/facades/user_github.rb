class UserGithub
  def initialize(token)
    @token = token
  end

  def repos
    user_repos(@token).map do |repo|
      Repo.new(repo)
    end.first(5)

  end

  private

  def user_repos(token)
    @_user_repos ||= service.repos_by_updated_at(token)
  end

  def service
    @_service ||= GithubService.new
  end
end
