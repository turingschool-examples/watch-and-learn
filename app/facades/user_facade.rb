class UserFacade
  attr_reader :first_name, :last_name, :email

  def initialize(user)
    @first_name = user.first_name
    @last_name = user.last_name
    @email = user.email
    @token = user.token
  end

  def repos
    service = GithubService.new(token: @token)
    repos = service.get_repos
  end

end
