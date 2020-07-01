class GithubService
  def conn
    Faraday.new(url: 'https://api.github.com') do |faraday|
      faraday.headers['Authorization'] = ENV['GITHUB_API_KEY']
      # faraday.headers['Authorization'] = "token 484cabdee3b4e5de4226ed80470600b274e435d9"
    end
  end

  def repos_body
    response = conn.get('/user/repos')
    JSON.parse(response.body, symbolize_names: true)
  end
end
