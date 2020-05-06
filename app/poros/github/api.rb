require 'faraday'
require 'json'
require_relative 'follower'
require_relative 'following'
require_relative 'repo'

class Api
  attr_reader :followers, :following, :repos

  def initialize(current_user)
    @current_user = current_user
    @connection ||= connect
    @followers ||= parse_followers
    @following ||= parse_following
    @repos ||= parse_repos
  end

  private

  def parse_info(info)
    conn = @connection.get("/user/#{info}")
    JSON.parse(conn.body, symbolize_names: true)
  end

  def connect
    Faraday.new(url: 'https://api.github.com',
                params: { access_token: @current_user[:git_hub_token] })
  end
  
  def parse_followers
    parse_info('followers').map { |follower| Follower.new(follower) }
  end
  
  def parse_following 
    parse_info('following').map { |user| Following.new(user) }
  end

  def parse_repos 
    parse_info('repos?sort="created"').map { |repo| Repo.new(repo) }
  end
end
