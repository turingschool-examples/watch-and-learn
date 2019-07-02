class GithubFacade
  attr_reader :token
  def initialize(token)
    @token = token
  end

  def repos
    conn = Faraday.new(url: "https://api.github.com") do |f|
      f.headers["Authorization"] = "token #{@token}"
      f.adapter Faraday.default_adapter
    end
    response = conn.get("/user/repos")
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    new_response = parsed_response.take(5)
    repo_array = []
    new_response.each do |repo|
      repo_array << Repo.new(repo)
    end
    repo_array
  end
end
