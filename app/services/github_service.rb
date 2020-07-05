class GithubService
  def initialize(token)
    @token = token
  end

  def repos
    all_repos = conn.get('user/repos')
    JSON.parse(all_repos.body, symbolize_names: true)[0..4].map do |repo|
      [repo[:html_url], repo[:name]]
    end
  end

  def followers
    auth = conn.get('user/followers')
    JSON.parse(auth.body, symbolize_names: true).map do |follower_info|
      GithubUser.new(follower_info)
    end
  end

  def following
    auth = conn.get('user/following')
    JSON.parse(auth.body, symbolize_names: true).map do |follower_info|
      GithubUser.new(follower_info)
    end
  end

  def conn
    Faraday.new('https://api.github.com') do |f|
      f.headers['Authorization'] = "token #{@token}"
    end
  end
end
