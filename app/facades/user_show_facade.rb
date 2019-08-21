class UserShowFacade

  def user_repos
    conn = Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.headers["X-API-KEY"] = ENV['GITHUB_API_KEY']
      faraday.params['per_page'] = 5
      faraday.adapter Faraday.default_adapter
   end

    response = conn.get("/users/MillsProvosty/repos")

    repo = JSON.parse(response.body, symbolize_names: true)

    repo.map do |r|
      GithubRepo.new(r)
    end
  end


end
