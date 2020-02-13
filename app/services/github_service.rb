class GithubService
  def self.repos(token)
    response = Faraday.get("https://api.github.com/user/repos?access_token=#{token}")
    JSON.parse(response.body, sybomlize_names: true)
  end

  def self.followers(token)
    response = Faraday.get("https://api.github.com/user/followers?access_token=#{token}")
    JSON.parse(response.body, sybomlize_names: true)
  end

  def self.following(token)
    response = Faraday.get("https://api.github.com/user/following?access_token=#{token}")
    JSON.parse(response.body, sybomlize_names: true)
  end

  def self.user_email(handle, token)
    response = Faraday.get("https://api.github.com/users/#{handle}?access_token=#{token}")
    json = JSON.parse(response.body, sybomlize_names: true)
    { email: json['email'], name: json['name'] }
  end
end
