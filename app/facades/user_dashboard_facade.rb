class UserDashboardFacade
  def initialize(user)
    @user = user
  end

  def find_all_followers
    data = service.find_followers
    data.map do |raw_follower|
      Follower.new(raw_follower)
    end
  end

  def find_all_following
    data = service.find_following
    data.map do |raw_following|
      Following.new(raw_following)
    end
  end

  def find_all_repos
    data = service.find_repos
    data.map do |raw_repo|
      Repo.new(raw_repo)
    end
  end

  def service
    GithubService.new(@user)
  end
end
