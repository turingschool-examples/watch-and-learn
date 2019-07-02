# frozen_string_literal: true

class GithubService
  def repo_info
    params = { part: 'owner', id: id }
    JSON.parse(conn.get('/user/repos', params).body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://api.github.com') do |f|
      f.adapter Faraday.default_adapter
      f.token_auth ENV['github-test-key']
    end
  end
end
