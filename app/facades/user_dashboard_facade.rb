class UserDashboardFacade

  def initialize(user)
    @user = user
  end

  def repos
    @repos ||= repo_data[0..4].map {|data| Repo.new(data)}
  end

  def followers
    @_followers ||= follower_data.map {|data| Follower.new(data)}
  end

  def following
    @_following ||= following_data.map {|data| Follower.new(data)}
  end

  private

  def service
    @_service ||= GithubApi.new(@user)
  end

  def following_data
    @_following_data ||= service.following
  end

  def repo_data
    @_repo_data ||= service.repos
  end

  def follower_data
    @_follower_data ||= service.followers
  end

end
