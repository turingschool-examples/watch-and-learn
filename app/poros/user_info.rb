class UserInfo

  # def git
  #   service = GithubService.new
  #   service.github_repos.map do |repo|
  #     Repo.new(repo)
  #   end
  # end



  def github_repos
    service = GithubService.new
    @github_repos ||= service.repos_by_user.map do |repo|
      Repo.new(repo)
    end
  #
  #   access_token = '43eddb0d1c2125f11ea3452ffc1454ce0dfb5e37'
  #   conn = Faraday.new(url: 'https://api.github.com') do |faraday|
  #     faraday.params['access_token'] = access_token
  #     faraday.adapter Faraday.default_adapter
  #   end
  #   response = conn.get('user/repos')
  #   json = JSON.parse(response.body, symbolize_names: true)
  #   repos = json.take(5)
  #
  #   repos.map do |repo|
  #     Repo.new(repo)
  #   end
  end
end
