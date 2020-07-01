class GithubService
  def fetch_repos_for_user
    headers = { Authorization: "token #{ENV['GITHUB_TOKEN']}" }
    response = get_json('https://api.github.com/user/repos', {}, headers)

    first_five = response[0..4]
    repos = first_five.map do |repo|
      {name: repo[:name], html_url: repo[:html_url] }
    end
  end

  def fetch_followers_for_user
    headers = { Authorization: "token #{ENV['GITHUB_TOKEN']}" }
    response = get_json('https://api.github.com/user/followers', {}, headers)
    followers = response.map do |follower|
      {login: follower[:login], html_url: follower[:html_url] }
    end
  end

  private

  def get_json(url, params, headers)
    response = conn.get(url, params, headers)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://api.github.com') do |conn|
      conn.adapter Faraday.default_adapter
      conn.params[:key] = ENV['GITHUB_SERVICE']
    end
  end
end
