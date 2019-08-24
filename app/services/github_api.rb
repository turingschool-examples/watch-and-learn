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
      faraday.basic_auth('pschlatt', '76a6bc8ef950980ab3650a9923ba80dd1e184584')
      faraday.adapter Faraday.default_adapter

  end

end
  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
