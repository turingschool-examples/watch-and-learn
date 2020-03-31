class SearchFacade

  def get_repos(username)
    get_repos_data(username)
  end

  def get_followers(username)
    get_followers_data(username)
  end 

  private

  def get_repos_data(username)
    response = connection.get("/users/#{username}/repos")
    json = JSON.parse(response.body, symbolize_names: true)
  end
  
  def get_followers_data(username)
    response = connection.get("/users/#{username}/followers")
    json = JSON.parse(response.body, symbolize_names: true)
  end

  def connection
    conn = Faraday.new(url: "https://api.github.com/")
  end 
end
