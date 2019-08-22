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
    @_conn = Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.basic_auth('wthompson92', '3d31a0c9b71f97bed245daf41070155cd6d0b73b')
      faraday.adapter Faraday.default_adapter

  end

end
  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
