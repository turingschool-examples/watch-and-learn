class GithubService
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def user_repos
    get_json('user/repos')
  end

  def user_followers
    get_json('user/followers')
  end

  def user_following
    get_json('user/following')
  end

  private

  def conn
    Faraday.new(url: 'https://api.github.com') do |f|
      f.headers['Authorization'] = "token #{@user.token}"
    end
  end

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
