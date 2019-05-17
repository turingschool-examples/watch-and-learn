class GithubService
  def initialize(filter)
    @token = filter[:token]
  end

  def get_email(github_handle)
    conn = Faraday.new("https://api.github.com/users/#{github_handle}?access_token=#{@token}")
    response  = conn.get
    data = JSON.parse(response.body, symbolize_names: true)
  end

  def get_repos
    conn = Faraday.new("https://api.github.com/user/repos?access_token=#{@token}&affiliation=owner")
    response  = conn.get
    data = JSON.parse(response.body, symbolize_names: true)
    data.take(5)
  end

  def get_following
    conn = Faraday.new("https://api.github.com/user/following?access_token=#{@token}&affiliation=owner")
    response  = conn.get
    data = JSON.parse(response.body, symbolize_names: true)
  end

  def get_followers
    conn = Faraday.new("https://api.github.com/user/followers?access_token=#{@token}&affiliation=owner")
    response  = conn.get
    data = JSON.parse(response.body, symbolize_names: true)
  end
end
