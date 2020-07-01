class GithubService

  def conn
    Faraday.new(url: 'https://api.github.com') do |faraday|
      faraday.headers['Authorization'] = ENV['GITHUB_API_KEY']
    end
  end

  def get_url(url)
    response = conn.get("/user/#{url}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def repos
    get_url('repos')
  end

  def followers
    get_url('followers')
  end

  def followings
    get_url('following')
  end
end
