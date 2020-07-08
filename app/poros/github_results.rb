class GithubResults
  def initialize(current_user)
    @github_service = GithubService.new(current_user)
  end

  def repos
    repo_results = @github_service.repo_resp[0..4]
    repo_results.map do |resp|
      Repo.new(resp)
    end
  end

  def followers
    follower_results = @github_service.follower_resp
    follower_results.map do |resp|
      Follower.new(resp)
    end
  end

  def following
    following_results = @github_service.following_resp
    following_results.map do |resp|
      Following.new(resp)
    end
  end

  def user_email(username)
    email_results = @github_service.user_resp(username)
    if !email_results[:message].nil?
      email_results[:message]
    else
      email_results[:email]
    end
  end
end
