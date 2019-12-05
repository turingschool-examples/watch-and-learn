class GithubService
  def repos_by_user
    access_token = '43eddb0d1c2125f11ea3452ffc1454ce0dfb5e37'
    conn = Faraday.new(url: 'https://api.github.com') do |faraday|
      faraday.params['access_token'] = access_token
      faraday.adapter Faraday.default_adapter
    end
    response = conn.get('user/repos')
    json = JSON.parse(response.body, symbolize_names: true)
    repos = json.take(5)
  end
end
