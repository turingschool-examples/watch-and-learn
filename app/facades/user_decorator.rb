class UserDecorator < SimpleDelegator

  def initialize(user)
    @user = super(user)
  end

  def repos
    raw_repo_data = get_repo_data
    create_repos(raw_repo_data)
  end

  private
    attr_reader :user

    def get_repo_data
      @raw_repo_data ||= service.fetch_repos
    end

    def service
      GithubService.new(user.token)
    end

    def create_repos(raw_repo_data)
      raw_repo_data.map do |repo|
        Repo.new(repo)
      end[0..4]
    end
end
