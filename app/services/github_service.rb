class GithubService
  def initialize(token)
    @token = token
  end

  def repos_by_user
    get_json('/user/repos')
  end

  def followings_by_user
    get_json('/user/following')
  end

  def followers_by_user
    get_json('/user/followers')
  end

  def invitee_of_user(handle)
    require "pry"; binding.pry
    get_json("/users/#{handle}")
  end

  private

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://api.github.com') do |faraday|
      faraday.params['access_token'] = @token
      faraday.adapter Faraday.default_adapter
    end
  end
end
