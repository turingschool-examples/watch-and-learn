class UserDashboardFacade 

  def initialize(user)
    @user = user
  end

  def repos  
    raw_data = GithubService.new(@user).all_repos
    raw_data[0..4].map do |data|
      GithubInfo.new(data)
    end
  end

  def followers
    raw_data = GithubService.new(@user).all_followers
    raw_data.map do |data|
      Follower.new(data)
    end
  end

  def following 
    raw_data = GithubService.new(@user).all_following
    raw_data.map do |data|
      Following.new(data)
    end
  end

end
