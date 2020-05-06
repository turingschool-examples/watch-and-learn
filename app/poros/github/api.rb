require 'faraday'
require 'json'
require_relative 'follower'
require_relative 'repo'

class Api
  attr_reader :followers, :repos

  def initialize(current_user)
    @current_user = current_user
    @connection = connect
    @followers = parse_info('followers').map { |follower| Follower.new(follower) }
    @repos = parse_info('repos?sort="created"').map { |repo| Repo.new(repo) }
  end

  def parse_info(info)
    conn = @connection.get("/user/#{info}")
    JSON.parse(conn.body, symbolize_names: true)
  end

  def connect
    Faraday.new(url: 'https://api.github.com',
                params: { access_token: @current_user[:git_hub_token] })
  end
end
