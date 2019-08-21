class FollowingFacade
	attr_reader :following

	def initialize
		@following = following
	end

	def following
		following_data.map { |data| Following.new(data) }
	end

	private

	def service
		@_service ||= GithubService.new
	end

	def following_data
		@_following_data ||= service.following_data
	end

end
