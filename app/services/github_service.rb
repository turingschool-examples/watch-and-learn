class GithubService

  def conn
    Faraday.new(url: 'https://api.github.com') do |faraday|
      faraday.headers['Authorization'] = ENV['GITHUB_API_KEY']
    end
  end

  def get_url(url, token = nil)
    response = conn.get("/user/#{url}")
    if token
      response = conn.get("/user/#{url}?access_token=#{token}")
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def repos(token)
    get_url('repos', token)
  end

  def followers(token)
    get_url('followers', token)
  end

  def followings(token)
    get_url('following', token)
  end
end
