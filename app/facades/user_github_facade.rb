class UserGithubFacade
  def initialize(user)
    @user = user
  end

  def user_repos
    @user_repos ||= service.get_user_repos(@user).map do |repo_data|
      Repo.new(repo_data)
    end
  end

  def user_followers
    @user_followers ||= service.get_user_followers(@user).map do |follower_data|
      GithubUser.new(follower_data)
    end
  end

  def user_following
    @user_following ||= service.get_user_following(@user).map do |following_data|
      GithubUser.new(following_data)
    end
  end

  def user_friends
    @user.friends
  end

  def service
    GithubService.new
  end


  def github_partial(current_user)
    if current_user.github_token
      "user_dashboard_github_info.html.erb"
    else
      "user_dashboard_no_github_token.html.erb"
    end
  end
end
