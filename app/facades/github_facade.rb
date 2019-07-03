class GithubFacade
  attr_reader :token
  def initialize(token)
    @token = token
  end

  def repos
    github_data = GithubApiService.new(token)
    new_response = github_data.repos
    new_array = new_response.map do |repo|
      Repo.new(repo)
    end
    new_array
  end

  def following
    user_data = GithubApiService.new(token).following
    user_data.map do |user|
      FollowingUser.new(user)
    end
  end

  def followers
    github_data = GithubApiService.new(token)
    new_response = github_data.followers
    follower_array = new_response.map do |follower|
      Follower.new(follower)
    end
    follower_array
  end
end
