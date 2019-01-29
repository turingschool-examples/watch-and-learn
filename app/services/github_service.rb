class GithubService

  def initialize(api_key)
    @api_key = api_key
  end

  def all_repos
    get_json("/user/repos?access_token=#{@api_key}")
  end

  private
  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(:url => "https://api.github.com") do |faraday|
      faraday.adapter Faraday.default_adapter
    end
  end
end
