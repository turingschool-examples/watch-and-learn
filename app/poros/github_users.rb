class GithubUsers
  def initialize(token)
    @token = token
  end

  def repos
    body = GithubService.new(@token).repos
    body.map do |repo_data|
      Repo.new(repo_data)
    end
  end

  def repos_limit(number)
    repos.first(number)
  end

  def followers
    body = GithubService.new(@token).followers
    body.map do |follower_data|
      Follower.new(follower_data)
    end
  end

  def followings
    body = GithubService.new(@token).followings
    body.map do |following_data|
      Following.new(following_data)
    end
  end
end
