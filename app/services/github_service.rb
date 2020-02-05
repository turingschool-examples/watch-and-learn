class GithubService
  def initialize(user)
    @user = user
  end
  def conn
    Faraday.new(url: "https://api.github.com") do |f|
      f.adapter Faraday.default_adapter
      f.params[:access_token] = @user.github_token
    end
  end
  def repos
    response = conn.get("user/repos")
    repo_data = JSON.parse(response.body, symbolize_names: true)
    repo_data[0..4].map do |data|
      GithubInfo.new(data[:name], data[:html_url])
    end
  end
end
