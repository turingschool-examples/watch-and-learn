class GithubService
  def initialize(token)
    @token = token
  end

  def retrieve_repos
    retrieve_json('repos').sample(5)
  end

  def retrieve_followers
    retrieve_json('followers')
  end

  def retrieve_followings
    retrieve_json('following')
  end

  private

  def connection
    Faraday.new('https://api.github.com/user') do |faraday|
      faraday.params['access_token'] = @token
      faraday.adapter Faraday.default_adapter
    end
  end

  def retrieve_json(url)
    response = connection.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
