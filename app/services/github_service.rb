class GithubService
  def initialize(user)
    @user = user
  end
  
  def git_repos
    search = conn.get('/user/repos')
    JSON.parse(search.body, symbolize_names: true)
  end
  
  def git_followers
    search = conn.get('/user/followers')
    JSON.parse(search.body, symbolize_names: true)
  end
  
  def git_following
    search = conn.get('/user/following')
    JSON.parse(search.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://api.github.com') do |faraday|
      faraday.headers['Authorization'] = "token #{@user.token}"
    end
  end
end