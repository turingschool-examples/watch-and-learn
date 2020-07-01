class GithubService

  attr_reader :user

  def initialize(user)
    @user = user
  end

  def user_repos
    get_json('user/repos')
  end

  private

  def conn
    Faraday.new(url: 'https://api.github.com') do |f|
      f.headers['Authorization'] = "token 6d37f331aab131ad424243bdf9065ecc18e809be"
    end
  end

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
