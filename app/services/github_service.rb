class GithubService
  def initialize(token)
    @token = token
  end

  def repositories
    get_json("/user/repos").map do |json_repo|
      Repository.new(json_repo)
    end
  end

  def followers
    get_json("/user/followers").map do |json_user|
      GithubUser.new(json_user)
    end
  end

  def following
    get_json("/user/following").map do |json_user|
      GithubUser.new(json_user)
    end
  end

  private

  def get_json(path)
    response = conn.get(path)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://api.github.com") do |fd|
      fd.headers["Authorization"] = "token #{@token}"
      fd.adapter Faraday.default_adapter
    end
  end
end
