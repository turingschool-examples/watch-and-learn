class GithubDataView

# Make private
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def repos
    service = GithubService.new
    service.repos_by_user(user).map do |repo_data|
      Repo.new(repo_data)
    end
  end

  def followers
    service = GithubService.new
    service.followers_by_user(user).map do |follower_data|
      Follower.new(follower_data)
    end
  end

  def following
    service = GithubService.new
    service.following_by_user(user).map do |following_data|
      Following.new(following_data)
    end
  end

end
