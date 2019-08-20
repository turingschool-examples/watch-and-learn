class FollowerFacade
  attr_reader :followers

  def initialize
    @followers ||= get_followers
  end

  def get_followers
    follower_data.map {|data| Follower.new(data)}
  end

  private

  def service
    @_service ||= GithubService.new
  end

  def follower_data
    @_follower_data ||= service.follower_data
  end
end
