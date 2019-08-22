class FollowersFacade
  def followers
    @_followers ||= follower_data.map {|data| Follower.new(data)}
  end

  private

  def service
    @_service ||= GithubApi.new
  end

  def follower_data
    @_follower_data ||= service.followers
  end
end
