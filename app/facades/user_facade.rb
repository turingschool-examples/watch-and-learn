class UserFacade
  attr_reader :service

  def initialize(current_user)
    @service = GithubApiService.new
    @current_user = current_user
  end

  def all_repo_data
    @service.get_user_data(@current_user).map do |repo_hash|
      Repo.new(repo_hash)
    end
  end

  #refactor to make data passed through dynamtic
  def limit_repo_five
    all_repo_data.first(5)
  end

  def repo_data
    limit_repo_five
  end
end
