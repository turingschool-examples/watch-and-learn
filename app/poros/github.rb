require 'faraday'
require 'json'

class Github
  attr_reader :followers, :repos

  def initialize(current_user)
    @current_user = current_user
    @connection = connect
    @followers = self.parse_info('followers')
    @repos = self.parse_info('repos?sort="created"')
  end

  def parse_info(info)
    conn = @connection.get("/user/#{info}")
    JSON.parse(conn.body, symbolize_names: true)
  end

  def connect
    Faraday.new(url: "https://api.github.com",
                params: { access_token: @current_user[:git_hub_token] })
  end
end
