class GithubService

  def conn(user)
    Faraday.new(url: 'https://api.github.com') do |f|
      f.headers['Authorization'] = "token #{user.token}"
      f.adapter Faraday.default_adapter
    end
  end

  def repos_by_user(user)
    repo_response = conn(user).get('/user/repos')
    JSON.parse(repo_response.body, symbolize_names: true)[0..4]
  end

  def followers_by_user(user)
    follower_response = conn(user).get('/user/followers')
    JSON.parse(follower_response.body, symbolize_names: true)
  end

  def following_by_user(user)
    following_resp = conn(user).get('/user/following')
    JSON.parse(following_resp.body, symbolize_names: true)
  end
end
