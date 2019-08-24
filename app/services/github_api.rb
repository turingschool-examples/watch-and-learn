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
      faraday.basic_auth('pschlatt', 'c3161359aedba9c1ef97d4f84f2b139dbe30d4e6')
      faraday.adapter Faraday.default_adapter

  end

end
  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
