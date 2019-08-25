class DashboardFacade
  attr_reader :token

	def initialize(current_user)
		@current_user = current_user
		@token = current_user.token("github")
	end

  def repositories
    @repositories ||= repository_data[0..4].map {|data| Repository.new(data)}
  end

  def followers
    @followers ||= follower_data.map {|data| Follower.new(data)}
  end

  def following
  	@following ||= following_data.map { |data| Following.new(data) }
  end

	def friends
	  @friends ||= @current_user.friendships.map { |data| Friend.new(data) }
	end

  def partial
    @token.nil? ? "github_login" : "github"
  end

  private

  def service
    @_service ||= GithubService.new(@token)
  end

  def repository_data
    @_repository_data ||= service.repository_data
  end

  def follower_data
    @_follower_data ||= service.follower_data
  end

  def following_data
  	@_following_data ||= service.following_data
  end
end
