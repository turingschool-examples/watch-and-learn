class UserInfo
  def github_repos
    access_token = '91df31c63511d25ac644207816e8d86b4c8e92a2'
    conn = Faraday.new(url: 'https://api.github.com') do |faraday|
      faraday.params['access_token'] = access_token
      faraday.adapter Faraday.default_adapter
    end
    response = conn.get('user/repos')
    json = JSON.parse(response.body, symbolize_names: true)
    repos = json.take(5)

    repos.map do |repo|
      Repo.new(repo)
    end
  end
end
