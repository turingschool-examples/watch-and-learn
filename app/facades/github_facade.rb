class GithubFacade
  def initialize()

  end

  def repos
    GithubService.new.repo_info.map do |repo|
      
    end
  end
end
