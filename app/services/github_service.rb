class GithubService
  def initialize(user)
    @user = user
  end
  def conn
    Faraday.new(url: "https://api.github.com") do |f|
      f.adapter  Faraday.default_adapter
      f.params[:access_token] = @user.github_token
    end

  end
  def get_repos
    response = conn.get("user/repos")
    repos = JSON.parse(response.body, symbolize_names: true)
    GithubInfo.new(repos)
  end
end

class GithubInfo
  def initialize(info)
    binding.pry
    @repo_name = info.first[:name]
  end
end
