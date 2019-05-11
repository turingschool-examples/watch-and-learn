class GithubService
  def initialize(filter)
    @token = filter[:token]
  end

  def get_repos
    conn = Faraday.new("https://api.github.com/user/repos?access_token=#{@token}&affiliation=owner")
    response  = conn.get
    data = JSON.parse(response.body, symbolize_names: true)
    data.take(5)
  end
end
