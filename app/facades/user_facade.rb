class UserFacade
  attr_reader :user

  def initialize(user)
    @user = user
    @git_service = GithubService.new(@user.token)
  end

  def repos
    @repos ||= begin
      raw_repos_data = @git_service.get_repos

      raw_repos_data.map do |repo|
        Repo.new(repo)
      end
    end
  end

  def followers
    @followers ||= begin
      raw_followers_data = @git_service.get_followers

      raw_followers_data.map do |follower|
        Follower.new(follower)
      end
    end
  end

  def followings
    @followings ||= begin
      raw_following_data = @git_service.get_followings

      raw_following_data.map do |following|
        Following.new(following)
      end
    end
  end
end
