class GithubService

  def initialize(user)
    @user = user
  end

  def get_repos
    get_json('/user/repos')
  end

  private

  def get_json(url)
    response = conn.get(url)
    data = JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new("https://api.github.com/users/#{@user.username}?access_token=#{@user.github_token}") do |f|
      f.adapter Faraday.default_adapter
    end
  end
end
