class GithubFacade
  def initialize(user)
    @user = user
  end

  def grab_repos
    data = service.repos
    repo_data = data.sample(5)
    repo_data.map do |repo|
      Repository.new(repo)
    end
  end

  def grab_followers
    data = service.followers
    data.map do |follower|
      Follower.new(follower)
    end
  end

  private

  def service
    GithubService.new(@user)
  end
end
