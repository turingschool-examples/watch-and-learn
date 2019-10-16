class GithubApiService

  def get_repo_data(user)
    json_response = conn(user).get("user/repos")
    parsed_data = JSON.parse(json_response.body, symbolize_names: true)
  end

  def get_follower_data(user)
    json_response = conn(user).get("user/followers")
    parsed_data = JSON.parse(json_response.body, symbolize_names: true)
  end

  def get_following_data(user)
    json_response = conn(user).get("user/following")
    parsed_data = JSON.parse(json_response.body, symbolize_names: true)
  end

  def search_user_login(user, github_login)
    json_response = conn(user).get("users/#{github_login}")
    parsed_data = JSON.parse(json_response.body, symbolize_names: true)
  end

  def conn(user)
    Faraday.new(
      url: 'https://api.github.com/',
      headers: {'Authorization' => "token #{user.github_token}"}
    )
  end
end
