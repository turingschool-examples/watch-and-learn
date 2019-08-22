class GithubService
	def initialize(token)
		@token = token
	end

  def repository_data
    get_json("/user/repos")
  end

  def follower_data
    get_json("/user/followers")
  end

	def following_data
		get_json("/user/followers")
	end

  private

  def conn
<<<<<<< HEAD
    @_conn ||= Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.headers["Authorization"] = ENV['GITHUB_API_KEY']
=======
    @_conn = Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.headers["Authorization"] = @token
>>>>>>> 6d7e861dec7ef7ab66b413241fa70b19f7d4c8aa
      faraday.headers["Accept"] = "application/vnd.github.v3+json"
      faraday.adapter Faraday.default_adapter
    end
  end

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
