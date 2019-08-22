class Github_Api
  def repos
    get_json("/user/repos")
  end

	end

  private

  def conn
    @_conn = Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.headers["Authorization"] = ENV['3d31a0c9b71f97bed245daf41070155cd6d0b73b']
      faraday.headers["Accept"] = "application/vnd.github.v3+json"
      faraday.adapter Faraday.default_adapter
    end
  end

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
