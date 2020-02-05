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
    repos.map do |data|
      lol = GithubInfo.new(data[:name], data[:html_url])
    end
  end
end

class GithubInfo
  attr_reader :name, :html
  def initialize(name, url)
    @name = name
    @html = url
  end
end
