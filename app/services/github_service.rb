class GithubService 
  def initialize(token, username)
    @token = token 
    @username = username
  end 
  
  def get_repos
    get_json('repos')[0..4]
  end
  
  def get_followers
    get_json('followers')
  end
  
  def get_followings
    get_json('following')
  end
  
  private 
  
  def connection
    Faraday.new(url: "https://api.github.com/users/#{@username}/") do |f|
      f.params['token'] = @token
      f.adapter Faraday.default_adapter
    end 
  end 
  
  def get_json(url)
    response = connection.get(url)
    json = JSON.parse(response.body, symbolize_names: true)
  end 
end 