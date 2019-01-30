class GithubService

  def initialize(access_token)
    @access_token = access_token
  end

  def repos
    get_json("user/repos").take(5)
  end

  private

  def get_json(path)
    response = connection.get(path)
    return [] unless response.status == 200
    response = JSON.parse(response.body, symbolize_names: true)
  end

  def connection
    Faraday.new(url: "https://api.github.com") do |f|
      f.adapter Faraday.default_adapter
      f.params = {access_token: @access_token}
    end
  end

end
