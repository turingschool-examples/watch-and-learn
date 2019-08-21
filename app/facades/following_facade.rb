class FollowingFacade

	def initialize
		@following = following
	end

	def following
		# service = GithubService.new
		service.following_data.map { |data| Following.new(data) }
	end

	private

	def service
		GithubService.new
	end

end
