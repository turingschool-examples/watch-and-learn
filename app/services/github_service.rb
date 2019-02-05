class GithubService
  def initialize(user)
    @user = user
  end

  def repos_by_user
    get_json('user/repos')
  end

  def followers_by_user
    get_json('user/followers')
  end
  
  def following_by_user
    get_json('user/following')
  end

  def self.email_by_username(username)
    connection = Faraday.new(url: 'https://api.github.com') do |faraday|
      faraday.headers['Accept'] = 'application/vnd.github.v3+json'
      faraday.params['client_id'] = ENV['GITHUB_CLIENT_ID']
      faraday.params['client_secret'] = ENV['GITHUB_CLIENT_SECRET']
      faraday.adapter Faraday.default_adapter
    end
    response = connection.get("/users/#{username}")
    JSON.parse(response.body, symbolize_names: true)
  end
  
  def conn
    Faraday.new(url: 'https://api.github.com') do |faraday|
      faraday.headers['Authorization'] = @user.github_token
      faraday.adapter Faraday.default_adapter
    end
  end

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
