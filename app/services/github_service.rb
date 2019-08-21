class GithubService
  def initialize
  end

  def create_repo
    get_json("/user/repos")
  end

  private
  def conn
    Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.headers["Authorization"] = ENV['GITHUB_API_KEY']
      faraday.params['per_page'] = 5
      faraday.adapter Faraday.default_adapter
    end
  end

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
# ]
#
#   repo =
#
#   repo.map do |r|
#     GithubRepo.new(r)
#   end
end
