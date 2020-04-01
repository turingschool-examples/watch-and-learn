class SearchFacade
  attr_reader :user

  def initialize(user)
    @user = user
    @git_service = GithubService.new(@user.github_token, @user.username)
  end

  def repos
    data = @git_service.get_repos
    @repos = data.map do |repo|
      Repository.new(repo)
    end
    return @repos
  end

  def followers
    data = @git_service.get_followers
    @followers = data.map do |follower|
      Follower.new(follower)
    end
    return @followers
  end

  def following
    data = @git_service.get_followings
    @following = data.map do |following|
      Following.new(following)
    end
    return @following
  end 
end
