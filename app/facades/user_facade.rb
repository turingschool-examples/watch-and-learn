class UserFacade
  def github_repos
    @_github_repos ||= repos[0..4].map { |repo| Repository.new(repo)}
  end

  def github_followers
    @_github_followers ||= followers.map { |follower| Follower.new(follower)}
  end

  private

  def service
    @_service ||= GithubService.new
  end

  def repos
    @_repos ||= service.repos
  end

  def followers
    @_followers ||= service.followers
  end
end
