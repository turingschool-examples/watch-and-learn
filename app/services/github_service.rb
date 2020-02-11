class GithubService

  def conn(user)
    Faraday.new(url: 'https://api.github.com') do |f|
      f.headers['Authorization'] = "token #{user.token}"
      f.adapter Faraday.default_adapter
    end
  end

  def repos_by_user(user)
    conn = conn(user)
    repo_response = conn.get('/user/repos')
    JSON.parse(repo_response.body, symbolize_names: true)[0..4]
  end

  def followers_by_user(user)
    conn = conn(user)
    follower_response = conn.get('/user/followers')
    JSON.parse(follower_response.body, symbolize_names: true)
  end

  def following_by_user(user)
    conn = conn(user)
    following_resp = conn.get('/user/following')
    JSON.parse(following_resp.body, symbolize_names: true)
  end
end
