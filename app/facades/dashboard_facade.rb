class DashboardFacade
  def initialize(user)
    if user.token
      @service = GithubService.new(user)
      @auth = true
    else
      @auth = false
    end
    @friendships = user.friendship_uids
  end

  def is_auth?; @auth end

  def repos
    if @auth
      @_repos ||= get_repos
    else
      []
    end
  end

  def followers
    @_followers ||= get_followers
  end
  
  def following
    @_following ||= get_following
  end

  private
  attr_reader :service

  def get_repos
    service.fetch_repos.take(5).map do |raw_repo|
      Github::Repo.new(raw_repo)
    end
  end

  def get_followers
    service.fetch_followers.map do |raw_follower|
      Github::Handle.new(raw_follower, @friendships)
    end
  end

  def get_following
    service.fetch_following.map do |raw_following|
      Github::Handle.new(raw_following, @friendships)
    end
  end
end
