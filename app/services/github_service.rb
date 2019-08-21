class GithubService
  def user_repo(user_name)
    get_json("/users/#{user_name}/repos.json")
  end

  private
  def connection
    Faraday.new(url: "https://api.github.com") do |faraday|
        faraday.headers["X-API-KEY"] = ENV['GITHUB_API_KEY']
        faraday.params['per_page'] = 5
        faraday.adapter Faraday.default_adapter
     end
   end

   def get_json(url)
      response = connection.get(url)

      repo = JSON.parse(response.body, symbolize_names: true)

      repo.map do |r|
        GithubRepo.new(r)
      end
    end
end
