class GithubSearch

  def initialize(github_token)
    @github_token = github_token
  end

  def user_repos
    service.get_repos.map do |repo_data|
      Repo.new(repo_data)
    end
  end

  def user_followers
    service.get_followers.map do |follower_data|
      Follower.new(follower_data)
    end
  end

  def user_followings
    service.get_followings.map do |following_data|
      Following.new(following_data)
    end
  end

  def service
    GithubService.new(@github_token)
  end
end
