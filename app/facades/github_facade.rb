class GithubFacade

  def initialize(token)
    @access_token = token
    @results = nil
  end

  def repos
    search_results.map do |result|
      Repository.new(result)
    end
  end

  private

  def search_results
    @results ||= service.repositories
  end

  def service
    GithubService.new(@access_token)
  end
end
