require 'faraday'
require 'json'
require_relative 'follower'
require_relative 'following'
require_relative 'repo'

class Response
  attr_reader :followers, :following, :repos

  def initialize(current_user)
    @connection = GithubService.connect(current_user)
    @followers = parse_followers
    @following = parse_following
    @repos = parse_repos
  end

  def user_info(gh_username)
    request = @connection.get("/users/#{gh_username}")
    response = JSON.parse(request.body, symbolize_names: true)
    { email: response[:email], name: response[:name] }
  end

  private

  def parse_info(info)
    conn = @connection.get("/user/#{info}")
    JSON.parse(conn.body, symbolize_names: true)
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
