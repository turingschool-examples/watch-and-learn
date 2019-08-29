class GithubApi

  def initialize(user)
    @user = user
  end

  def repos
    get_json("/user/repos")
  end

  def followers
    get_json("/user/followers")
  end

  def following
    get_json("/user/following")
  end

  def user_email(handle)
      get_json("/users/#{handle}")
  end

  private

  def conn
    conn = Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.params = {access_token: "#{@user.github_value.token}"}
      faraday.adapter Faraday.default_adapter
    end
  end

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
