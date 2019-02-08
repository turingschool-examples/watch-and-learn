class GithubEmailService
  def initialize(user, github_handle)
    @user = user
    @github_handle = github_handle
  end

  def find_email
    get_json("/users/#{@github_handle}")
  end

  private

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    token = @user.github_token
    Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.params["access_token"] = token
      faraday.adapter Faraday.default_adapter
    end
  end

end
