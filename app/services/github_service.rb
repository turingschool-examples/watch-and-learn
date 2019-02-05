class GithubService

  def initialize(api_key)
    @api_key = api_key
  end

  def all_repos
    get_json("/user/repos")
  end

  def all_followers
    get_json("/user/followers")
  end

  def all_following
    get_json("/user/following")
  end

  def find_email(github_handle)
    get_json("/users/#{github_handle}")
  end

  def find_my_name
    get_json("/user")
  end

  private

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(:url => "https://api.github.com") do |faraday|
      faraday.headers["Authorization"] = "token #{@api_key}"
      faraday.adapter Faraday.default_adapter
    end
  end
end
