class GithubService
  def get_json_repos(user)
    response = Faraday.get("https://api.github.com/user/repos?access_token=#{user.token}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def find_repos(user)
    get_json_repos(user).map do |data|
      Repo.new(data)
    end
  end
end
