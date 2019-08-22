class FollowingFacade
	def initialize(token)
		@token = token
	end

	def following
		@following = following_data.map { |data| Following.new(data) }
	end

	private

	def service
		@_service ||= GithubService.new(@token)
	end

	def following_data
		@_following_data ||= service.following_data
	end

end
