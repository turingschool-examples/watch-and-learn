class GithubService
  def get_repos
    response = conn.get do |req|
      req.url 'user/repos'
      req.params['affiliation'] = 'owner'
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_followers
    response = conn.get do |req|
      req.url 'user/followers'
      req.params['affiliation'] = 'owner'
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def conn
    Faraday.new('https://api.github.com/',
      headers: {'Authorization' => "bearer #{ENV['GITHUB_API_KEY']}"})
  end
end
