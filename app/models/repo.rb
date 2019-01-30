class Repo
  attr_reader :html_url, :name
  def initialize(attributes)
    @html_url = attributes[:html_url]
    @name = attributes[:name]
  end

  def self.find_all_repos(token)
    data = GithubService.find_repos(token)
    data.map do |raw_repo|
      Repo.new(raw_repo)
    end
  end

end
