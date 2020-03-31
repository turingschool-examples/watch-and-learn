class SearchFacade
  def get_repos(username)
    get_repos_data(username)
  end

  private

  def get_repos_data(username)
    conn = Faraday.new(url: "https://api.github.com/")
    response = conn.get("/users/#{username}/repos")
    json = JSON.parse(response.body, symbolize_names: true)
  end

end
