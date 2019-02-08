class EmailFacade
  def initialize(user, github_handle)
    @user = user
    @github_handle = github_handle
  end

  def find_the_email
    data = service.find_email
    Email.new(data[:email], data[:name])
  end

  def service
    GithubEmailService.new(@user, @github_handle)
  end
end
