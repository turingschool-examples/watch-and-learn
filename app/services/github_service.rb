class GithubService
  def initialize(token)
    @token = token
  end

  def get_repos
    get_json('repos').sample(5)
  end

  def get_followers
    get_json('followers')
  end
  
  def get_followings
    get_json('following')
  end

  private
  def connection
    Faraday.new("https://api.github.com/user") do |faraday|
      faraday.params['access_token'] = @token
      faraday.adapter Faraday.default_adapter
    end
  end

  def get_json(url)
   response = connection.get(url)
   JSON.parse(response.body, symbolize_names: true)
  end
end
