class UserShowFacade
  def initialize(current_user)
    @user = current_user
  end

  def user_repos
    # connection = GithubService.new
    conn = Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.headers["Authorization"] = ENV['GITHUB_API_KEY']
      faraday.params['per_page'] = 5
      faraday.adapter Faraday.default_adapter
   end
    response = conn.get("/user/repos")

    repo = JSON.parse(response.body, symbolize_names: true)

    repo.map do |r|
      GithubRepo.new(r)
    end
  end

   private
    attr_reader :user
end
