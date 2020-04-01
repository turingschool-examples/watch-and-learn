class SearchFacade
  attr_reader :user

  def initialize(user)
    @user = user
    @git_service = GithubService.new(@user.github_token, @user.username)
  end
  
  def repos
    data = @git_service.get_repos
    @repos = data.map do |repo|
      Repository.new(repo)
    end 
    return @repos
  end 
end
