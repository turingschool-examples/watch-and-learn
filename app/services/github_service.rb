class GithubService

  def initialize(current_user)
    @current_user = current_user
  end

  def get_repos
    get_json('user/repos')
  end

  def get_followers
    get_json('user/followers')
  end

  def get_following
    get_json('user/following')
  end

  def get_email(handle)
    get_json("users/#{handle}")[:email]
  end

  private

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new("https://api.github.com/") do |f|
      f.params[:access_token] = @current_user.access_token
      f.adapter Faraday.default_adapter
    end
  end

end
