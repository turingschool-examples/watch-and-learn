class GithubService
  def repos_by_user
    get_json('/user/repos')
  end

  private

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true).take(5)
  end

  def conn
    Faraday.new(url: 'https://api.github.com') do |faraday|
      faraday.params['access_token'] = ENV['GITHUB_TOKEN']
      faraday.adapter Faraday.default_adapter
    end
  end
end
