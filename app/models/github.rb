class Github
  class Repo
    attr_reader :name, :url

    def initialize(name, url)
      @name = name
      @url = url
    end
  end

  def self.list_repos(token)
    @token = token
    response = connect.get('/user/repos')
    data = JSON.parse(response.body, symbolize_names: true).take(5)
    data.map { |repo| Repo.new(repo[:name], repo[:html_url]) }
  end

  def self.connect
    Faraday.new('https://api.github.com') do |conn|
      conn.authorization :Bearer, @token
    end
  end
end
