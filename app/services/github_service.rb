class GithubService
  def github_repos(token)
    get_json('user/repos', token).first(5).map do |repo_info|
      Repo.new(name: repo_info['name'], url: repo_info['html_url'])
    end
  end

  def github_followers(token)
    get_json('user/followers', token).map do |followers_info|
      Follower.new(name: followers_info['login'], url: followers_info['html_url'])
    end
  end

  def github_following(token)
    get_json('user/following', token).map do |followee_info|
      Follower.new(name: followee_info['login'], url: followee_info['html_url'])
    end
  end

  private

    def connection
      Faraday.new('https://api.github.com') do |faraday|
        faraday.adapter Faraday.default_adapter
      end
    end

    def get_json(endpoint, token)
      response = connection.get(endpoint, { access_token: token })
      JSON.parse(response.body)
    end
end
