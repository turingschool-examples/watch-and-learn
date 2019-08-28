class GithubApi

  def initialize(user)
    @user = user
  end

  def repos
    get_json2("/user/repos")
  end

  def followers
    get_json2("/user/followers")
  end

  def following
    get_json2("/user/following")
  end


  private


    def conn
      @_conn2 = Faraday.new(url: "https://api.github.com") do |faraday|
        faraday.params = {access_token: "#{@user.github_info.token}"}
        faraday.adapter Faraday.default_adapter
      end
    end

    def get_json(url)
      response = conn2.get(url)
      JSON.parse(response.body, symbolize_names: true)
    end
end
