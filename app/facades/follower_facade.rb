class FollowerFacade
  def followers
    @followers ||= follower_data.map {|data| Follower.new(data)}
  end

  private

  def service
    @_service ||= GithubService.new
  end

  def follower_data
    @_follower_data ||= service.follower_data
  end
end
