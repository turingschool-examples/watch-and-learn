class GithubService
  def initialize(user) 
    @user = user 
  end
  def conn 
    Faraday.new(url: "https://api.github.com") do |f|
      f.adapter  Faraday.default_adapter
      f.params[:key] = ENV['GITHUB_ACCESS_TOKEN']
    end
  end
  def get_json(url, params)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
