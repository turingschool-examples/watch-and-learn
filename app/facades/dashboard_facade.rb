class DashboardFacade
  def initialize(user)
    @user = user
  end

  def repos(quantity)
    result = GithubService.new(@user).repos_by_user
    result.map do |raw_repo|
      Repository.new(raw_repo)
    end[0..quantity - 1]
  end

  def followers
    result = GithubService.new(@user).followers_by_user
    result.map do |raw_follower|
      Follower.new(raw_follower)
    end
  end
  
  def following
    result = GithubService.new(@user).following_by_user
    result.map do |raw_following|
      Following.new(raw_following)
    end
  end
end
