class FollowerFacade
	def initialize(token)
		@token = token
	end

  def followers
    @followers ||= follower_data.map {|data| Follower.new(data)}
  end

  private

  def service
    @_service ||= GithubService.new(@token)
  end

  def follower_data
    @_follower_data ||= service.follower_data
  end
end
