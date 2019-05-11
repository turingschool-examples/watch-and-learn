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
    repos.map do |repo|
      Repository.new(repo)
    end
  end

  def following
    service = GithubService.new(token: @token)
    users = service.get_following
  end

  def token?
    @token.nil?
  end
end
