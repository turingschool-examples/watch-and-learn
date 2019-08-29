class UserFacade

  def initialize(current_user)
    @current_user = current_user
  end

  def github_repos
    @_github_repos ||= repos[0..4].map { |repo| Repository.new(repo)}
  end

  def github_followers
    @_github_followers ||= followers.map { |follower| Follower.new(follower)}
  end

  def github_following
    @_github_following ||= following.map { |following| Following.new(following)}
  end

  def friends
    @current_user.reload.friends
  end

  def bookmarked_tutorials
   @current_user.bookmarked_tutorials
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

  def following
    @_following ||= service.following
  end
end
