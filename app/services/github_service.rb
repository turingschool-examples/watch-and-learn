class GithubService
  def get_json_repos
    user = current_user
    token = ENV['GITHUB_TOKEN_LOCAL']
    response = Faraday.get("https://api.github.com/user/repos?access_token=#{user.token}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def find_repos
    get_json_repos.map do |data|
      Repo.new(data)
    end
  end
end
