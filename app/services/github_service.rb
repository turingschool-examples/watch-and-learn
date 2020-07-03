class GithubService
  def initialize(current_user)
    @current_user = current_user
  end

  def conn
    Faraday.new(url: 'https://api.github.com') do |faraday|
      faraday.headers['Authorization'] = "token #{@current_user.github_token}"
    end
  end

  def repo_resp
    repo_resp = conn.get('/user/repos')
    JSON.parse(repo_resp.body, symbolize_names: true)
  end

  def follower_resp
    follower_resp = conn.get('/user/followers')
    JSON.parse(follower_resp.body, symbolize_names: true)
  end

  def following_resp
    following_resp = conn.get('/user/following')
    JSON.parse(following_resp.body, symbolize_names: true)
  end
end
