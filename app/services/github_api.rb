class GithubApi

  def repos
    get_json("/user/repos")
  end

  def followers
    get_json("/user/followers")
  end

  def following
    get_json("/user/following")
  end

  private

  def conn
     Faraday.new(url: "https://api.github.com")
       f.adapter Faraday.default_adapter
   end



  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
