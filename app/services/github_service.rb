class GithubService
  def conn
    Faraday.new(url: 'https://api.github.com') do |faraday|
      faraday.headers['Authorization'] = ENV['GITHUB_API_KEY']
    end
  end

  def repos_body
    response = conn.get('/user/repos')
    JSON.parse(response.body, symbolize_names: true)
  end
end
