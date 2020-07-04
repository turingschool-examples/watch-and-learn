class SearchResults
  def repos(token)
    @repos = GithubService.new(token).repos
  end

  def followers(token)
    @followers = GithubService.new(token).followers
  end

  def following(token)
    @followed_users = GithubService.new(token).following
  end
end
