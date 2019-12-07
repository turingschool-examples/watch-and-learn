class UserInfo
  attr_reader :user

  def initialize(user)
    @user = user
    @token = user.github_token
  end

  def github_repos
    service = GithubService.new(@token)
    @github_repos ||= service.repos_by_user.map do |repo|
      Repo.new(repo)
    end
  end

  def github_followings
    service = GithubService.new(@token)
    @github_followings ||= service.followings_by_user.map do |following|
      Following.new(following)
    end
  end

  def github_followers
    service = GithubService.new(@token)
    @github_followers ||= service.followers_by_user.map do |follower|
      Follower.new(follower)
    end
  end

  def has_account?(follower)
    User.where("handle = ?", follower.login).exists?
  end
end
