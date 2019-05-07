class GitHubFacade

  def initialize(user)
    @user = user
  end

  def repos
    conn = Faraday.new("https://api.github.com/users/earl-stephens/repos") do |f|
      f.headers["token"] = ENV["github_key"]
      f.adapter Faraday.default_adapter
    end
    binding.pry

    response = conn.get

    data = JSON.parse(response.body, symbolize_names: true)
    data[:results].map do |repo_data|
      Repo.new(repo_data)
    end
  end

end
