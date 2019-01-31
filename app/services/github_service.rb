class GithubService
  def initialize(github_key)
    @github_key = github_key
  end

  def self.retrieve_access_token(code)
    parse_response(Faraday.post(GithubOauthLinks.req_access_token(code)))
  end

  def owned_repos
    get_json("/user/repos?affiliation=owner")
  end

  def followers
    get_json("/user/followers")
  end

  def following
    get_json("/user/following")
  end

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def conn
    Faraday.new(:url => "https://api.github.com") do |faraday|
     faraday.headers["Accept"] = "application/vnd.github.v3+json"
     faraday.headers["Authorization"] = @github_key
     faraday.adapter Faraday.default_adapter
    end
  end

  def self.parse_response(response)
    response_hash = response.body.split("&").reduce({}) do |res, param|
      k, v = param.split("=")
      res[k] = v
      res
    end
    response_hash["access_token"]
  end
end
