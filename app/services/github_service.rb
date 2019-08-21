class GithubService
  def initialize(token)
    @conn = Faraday.new(:url => "https://api.github.com/") do |f|
      f.headers['Authorization'] = "token b2fb15e787b174eee08fdb2b26bbb44b33993322"
      # f.basic_auth('ktsune', token)
      f.adapter Faraday.default_adapter
    end
  end

  def fetch_repos
    fetch('/user/repos')
  end

  private
  attr_reader :conn

  def fetch(uri)
    JSON.parse(conn.get(uri).body, symbolize_names: true)
  end
end
