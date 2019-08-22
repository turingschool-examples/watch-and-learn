class FollowingFacade
  def following
    @_following ||= following_data.map {|data| Follower.new(data)}
  end

  private

  def service
    @_service ||= GithubApi.new
  end

  def following_data
    @_following_data ||= service.following
  end
end
