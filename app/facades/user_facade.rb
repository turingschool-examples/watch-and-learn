class UserFacade
  def github_repos
    @_github_repos ||= repos[0..4].map { |repo| Repository.new(repo)}
  end

  private

  def service
    @_service ||= GithubService.new
  end

  def repos
    @_repos ||= service.repos
  end
end
