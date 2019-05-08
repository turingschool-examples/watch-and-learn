class GithubService

  def get_repos
    get_json('user/repos')
  end

  private

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new("https://api.github.com/") do |f|
      f.params[:access_token] = "37b234d311f8471034fd13111193888eb5e9de72"
      f.adapter Faraday.default_adapter
    end
  end

end
