class GithubResults
  def repos(token)
    json = GithubService.new.repos(token)
    @repos = json.map { |repo_data| Repo.new(repo_data) }
  end

  def followers(token)
    json = GithubService.new.followers(token)
    followers = json.map { |follower_data| Follower.new(follower_data) }
  end

  def followings(token)
    json = GithubService.new.followings(token)
    followings = json.map { |following_data| Following.new(following_data) }
  end
end
