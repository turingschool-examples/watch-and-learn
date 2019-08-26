class UserGithub
  def initialize(token)
    @token = token
  end

  def repos
    user_repos(@token.token).map do |repo|
      Repo.new(repo)
    end.first(5)
  end

  def followers
    user_followers(@token.token).map do |follower|
      Follower.new(follower)
    end
  end

  def followings
    user_followings(@token.token).map do |following|
      Following.new(following)
    end
  end

  private

  def user_repos(token)
    @_user_repos ||= service.repos_by_updated_at(token)
  end

  def user_followers(token)
    @user_followers ||= service.followers(token)
  end

  def user_followings(token)
    @user_followings ||= service.followings(token)
  end

  def service
    @_service ||= GithubService.new
  end
end
