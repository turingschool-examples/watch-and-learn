class GithubService
  def initialize(token)
    @token = token
  end

  def fetch_repos
    response = fetch_data("user/repos")
    parse_data(response)
  end

  def fetch_followers
    response = fetch_data("user/followers")
    parse_data(response)
  end

  def fetch_following
    response = fetch_data("user/following")
    parse_data(response)
  end

  private
    def fetch_data(url)
      conn.get(url)
    end

    def parse_data(response)
      JSON.parse(response.body, symbolize_names: true)
    end

    def conn
      Faraday.new(url: 'https://api.github.com') do |faraday|
        faraday.params["access_token"] = @token
        faraday.adapter Faraday.default_adapter
      end
    end
end
