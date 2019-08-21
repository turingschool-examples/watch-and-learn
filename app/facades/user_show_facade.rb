class UserShowFacade
  def initialize(current_user)
    @user = current_user
  end

  def user_repos
    connection = GithubService.new.create_repo

    connection.map do |r|
      GithubRepo.new(r)
    end
  end

    private
     attr_reader :user
end
