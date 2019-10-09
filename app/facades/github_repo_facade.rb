class GithubRepoFacade
  attr_reader :service

  def initialize(current_user)
    @service = GithubApiService.new
    @current_user = current_user
  end

  # refactor to split method
  def all_repo_data
    @service.get_user_data(@current_user).map do |d|
      Repo.new(d)
    end
  end

  def limit_repo_5
    all_repo_data[0..4]
  end

  def repo_data
    limit_repo_5
  end
end