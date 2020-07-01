class GithubUsers

  def repos
    body = GithubService.new.repos
    body.map do |repo_data|
      Repo.new(repo_data)
    end
  end

  def repos_limit(number)
    repos.first(number)
  end

  def followers
    body = GithubService.new.followers
    body.map do |follower_data|
      Follower.new(follower_data)
    end
  end
end
