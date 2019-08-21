class GithubService
  def initialize(token)
    @conn = Faraday.new("https://api.github.com") do |f|
      f.adapter Faraday.default_adapter
      f.headers['Authorization'] = token
    end
  end

  def fetch_repos
    binding.pry
    conn.get('/user/repos').body
  end

  private
  attr_reader :conn
end
