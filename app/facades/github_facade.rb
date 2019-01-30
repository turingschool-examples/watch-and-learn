class GithubFacade

  def initialize(token)
    @access_token = token
    @_followers = nil
    @_repos = nil
  end

  def repos
    find_repos.map do |repo|
      Repository.new(repo)
    end
  end

  def followers
    find_followers.map do |follower|
      Follower.new(follower)
    end
  end

  private

  def find_repos
    @_repos ||= service.repos
  end

  def find_followers
    @_followers ||= service.followers
  end

  def service
    GithubService.new(@access_token)
  end
end
