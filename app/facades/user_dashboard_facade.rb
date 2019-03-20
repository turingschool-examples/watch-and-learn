class UserDashboardFacade

  def initialize(user)
    @user = user
  end

  #is there a better name we could use here?
  def users_followed
    response = service.get_users_followed
    response.map do |user_data|
      GithubUser.new(user_data)
    end

  end


  def user_repos
    response = service.get_repos
    response.map do |repo_data|
      Repository.new(repo_data)
    end
  end

#change from Follower.new to GithubUser.new
  def user_followers
    response = service.get_followers
    response.map do |follower_data|
      Follower.new(follower_data)
    end
  end

  def top_user_repos(quantity)
    user_repos[0,quantity]
  end

  def service
    GithubService.new(@user)
  end
end
