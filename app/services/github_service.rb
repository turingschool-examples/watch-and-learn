# frozen_string_literal: true

class GithubService
  def get_user_repos(user)
    get_json('user/repos', user)
  end

  def get_user_followers(user)
    get_json('user/followers', user)
  end

  def get_user_following(user)
    get_json('user/following', user)
  end

  def get_user_email(username, user)
    get_json("users/#{username}", user)[:email]
  end

  def get_json(url, user)
    response = conn(user).get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn(user)
    Faraday.new(url: 'https://api.github.com/') do |faraday|
      faraday.headers['Authorization'] = 'token ' + user.github_token
      faraday.adapter Faraday.default_adapter
    end
  end
end
