# frozen_string_literal: true

class GithubService
  def repo_info
    get_json('/user/repos', sort: 'updated')
  end

  private
  def get_json(url, params)
    response = conn.get(url, params)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://api.github.com') do |f|
      f.basic_auth('james-cape', ENV['GITHUB_TOKEN'])
      f.adapter Faraday.default_adapter
    end
  end
end
