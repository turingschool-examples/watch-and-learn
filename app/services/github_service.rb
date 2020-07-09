class GithubService
  def conn(user)
    Faraday.new(url: "https://api.github.com") do |faraday|
    faraday.headers['Authorization'] = "token #{user.token}"
    end
  end

  def repo_json(user)
    response = conn(user).get("user/repos")
    JSON.parse(response.body, symbolized_names: true)[0..4]
  end

  def follower_json(user)
    response = conn(user).get("/user/followers")
    JSON.parse(response.body, symbolized_names: true)
  end

  def following_json(user)
    response = conn(user).get("/user/following")
    JSON.parse(response.body, symbolized_names: true)
  end

  def user_json(user)
    response = conn(user).get("/user")
    JSON.parse(response.body, symbolized_names: true)
  end

  def invitee_json(user, handle)

    response = conn(user).get("/users/#{handle}")

    JSON.parse(response.body, symbolized_names: true)


  end
end
