class GithubService
  def repo_info
    JSON.parse(conn.get('/user/repos').body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://api.github.com') do |f|
      f.adapter Faraday.default_adapter
      # f.header['Authorization'] = ENV['github-test-key']
      f.basic_auth("Myrdden", ENV['github-test-key'])
    end
  end
end
