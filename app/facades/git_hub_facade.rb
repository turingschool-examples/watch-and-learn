require_relative '../models/github/repo'
class GitHubFacade

  def initialize(user)
    @user = user
  end

  def repos
    conn = Faraday.new("https://api.github.com/users/#{@user.username}?access_token=#{@user.github_token}") do |f|
      f.adapter Faraday.default_adapter
    end

    response = conn.get("/user/repos")

    data = JSON.parse(response.body, symbolize_names: true)
    data = data.sample(5)
    # binding.pry
    data.map do |repo_data|
      Repo.new(repo_data)
    end
  end

end
