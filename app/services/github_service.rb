class GithubService

  def initialize(user_id)
    # require 'pry'; binding.pry
    @user = User.find(user_id)

  end

  def get_repos
    get_json("/repos#list-your-repositories")
    require 'pry'; binding.pry
  end

  private

    def get_json(url)
      response = conn.get(url)
      data = JSON.parse(response.body, symbolize_name: true)
    end

    def conn
    # require 'pry'; binding.pry
      Faraday.new("https://developer.github.com/v3/") do |f|
        f.headers["X-Api-Key"] = ENV["GITHUB_KEY"]
        f.adapter Faraday.default_adapter
      end
    end

end