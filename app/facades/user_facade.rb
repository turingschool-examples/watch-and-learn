class UserFacade
  def github_repos
    @github_repos ||= repos[0..4].map do |repo|
      Repository.new(repo)
    end
  end

  private

  def service
    @_service ||= GithubService.new
  end

  def repos
    @_repos ||= service.repos
  end
end
