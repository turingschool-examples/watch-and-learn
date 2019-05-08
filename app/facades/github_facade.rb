class GithubFacade

  def initialize(current_user)
    @current_user = current_user
  end

  def repos
    @conn = Faraday.new("https://api.github.com") do |f|
      f.params[:access_token] = "37b234d311f8471034fd13111193888eb5e9de72"
      f.adapter Faraday.default_adapter
    end

    response = @conn.get('/user/repos')
    repos = JSON.parse(response.body, symbolize_names: true)

    repos.map do |repo_data|
      Repo.new(repo_data)
    end
  end

end
