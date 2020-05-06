require 'faraday'
require 'json'

class GithubApi

  def initialize(current_user)
    @current_user = current_user
    @connection = connection
  end

  def parse_info(info)
    conn = @connection.get("/user/#{info}")
    JSON.parse(conn.body, symbolize_names: true)
  end

  def connection
    Faraday.new(url: "https://api.github.com",
                params: { access_token: @current_user[:git_hub_token] })
  end
end
