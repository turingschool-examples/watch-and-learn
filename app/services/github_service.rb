class GithubService

  def initialize(access_token)
    @access_token = access_token
  end

  def repositories
    get_json("user/repos")
  end

  private

  def connection
    binding.pry
    Faraday.new(url: "https://api.github.com") do |f|
      f.adapter Faraday.default_adapter
      f.params = {access_token: @access_token}
    end
  end

  def get_json(path)
    response = connection.get(path)
    JSON.parse(response.body, symbolize_name: true)
  end

end
