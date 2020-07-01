class GithubResults
  def repos(token)
    json = GithubService.new.repos(token)
    @repos = json.map { |repo_data| Repo.new(repo_data) }
  end

  def followers(token)
    json = GithubService.new.followers(token)
    followers = json.map { |follower_data| Follower.new(follower_data) }
    # require "pry"; binding.pry
  end
end
