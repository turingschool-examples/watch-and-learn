class GithubService

  def get_repos(quantity = 0, current_user)
    repos = get_json('/user/repos', current_user)
    range = (quantity - 1)
    repos[0..range]
  end

  def get_followers(current_user)
    get_json('/user/followers', current_user)
  end

  def get_following(current_user)
    get_json('/user/following', current_user)
  end

  def get_json(url, current_user)
    response = conn(current_user).get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn(current_user)
    Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.headers["Authorization"] = "token #{current_user.access_token}"
      faraday.adapter Faraday.default_adapter
    end
  end
end
