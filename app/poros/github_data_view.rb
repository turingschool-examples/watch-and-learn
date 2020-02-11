class GithubDataView

  attr_reader :user

  def initialize(user)
    @user = user
  end

  def repos
    repo_hash.map do |repo_data|
        Repo.new(repo_data)
      end
  end

  def repo_hash
    conn = Faraday.new(url: 'https://api.github.com') do |f|
        f.headers['Authorization'] = "token #{user.token}"
        f.adapter Faraday.default_adapter
      end

    repo_response = conn.get('/user/repos')
    JSON.parse(repo_response.body, symbolize_names: true)[0..4]
  end

  def followers
    follower_hash.map do |follower_data|
      Follower.new(follower_data)
    end
  end

  def follower_hash
    conn = Faraday.new(url: 'https://api.github.com') do |f|
      f.headers['Authorization'] = "token #{user.token}"
      f.adapter Faraday.default_adapter
    end

    follower_response = conn.get('/user/followers')
    JSON.parse(follower_response.body, symbolize_names: true)
  end

  #   conn = Faraday.new(url: 'https://api.github.com') do |f|
  #     f.headers['Authorization'] = "token #{user.token}"
  #     f.adapter Faraday.default_adapter
  #   end
  #
  #   repo_response = conn.get('/user/repos')
  #   repo_hash = JSON.parse(repo_response.body, symbolize_names: true)[0..4]
  #   @repos = repo_hash.map do |repo_data|
  #     Repo.new(repo_data)
  #   end
  #
  #   follower_response = conn.get('/user/followers')
  #   follower_hash = JSON.parse(follower_response.body, symbolize_names: true)
  #   @followers = follower_hash.map do |follower_data|
  #     Follower.new(follower_data)
  #   end
  #
  #   following_resp = conn.get('/user/following')
  #   following_hash = JSON.parse(following_resp.body, symbolize_names: true)
  #   @following = following_hash.map do |following_data|
  #     Following.new(following_data)
  #   end


end
