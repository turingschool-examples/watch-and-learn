class GithubApiService

  def initialize(token)
    @token = token
  end


  def repos(limit = 5)
    response = conn.get("/user/repos")
    new_response = parsed_response(response)
    new_response.take(limit)
  end

  def following
    parsed_response(conn.get('/user/following'))
  end

  private

  def parsed_response(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://api.github.com") do |f|
      f.headers["Authorization"] = "token #{@token}"
      f.adapter Faraday.default_adapter
    end
  end
end
