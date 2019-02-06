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

  def info_by_username(username)
    get_json("/users/#{username}")
  end
  
  private 
  
  def token_conn
    Faraday.new(url: 'https://api.github.com') do |faraday|
      faraday.params['access_token'] = @user.github_token
      faraday.adapter Faraday.default_adapter
    end
  end
  
  # def self.application_conn
  #   Faraday.new(url: 'https://api.github.com') do |faraday|
  #     faraday.params['client_id'] = ENV['GITHUB_CLIENT_ID']
  #     faraday.params['client_secret'] = ENV['GITHUB_CLIENT_SECRET']
  #     faraday.adapter Faraday.default_adapter
  #   end
  # end

  def get_json(url)
    response = token_conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
  
  # def self.get_json_by_username(username)
  #   response = application_conn.get("/users/#{username}")
  #   JSON.parse(response.body, symbolize_names: true)
  # end
end
