class GithubService

  def initialize(access_token)
    @access_token = access_token
  end

  def repositories
    get_json("user/repos")
  end

  private

  def get_json(path)
    response = connection.get(path)
    response = JSON.parse(response.body, symbolize_names: true)
    response[:message] == "Requires authentication" ? [] : response
  end

  def connection
    Faraday.new(url: "https://api.github.com") do |f|
      f.adapter Faraday.default_adapter
      f.params = {access_token: @access_token}
    end
  end

end
