class Repo
  attr_reader :name, :url
  def initialize(data)
    @name = data[:name]
    @url = data[:url]
  end

  def self.find_repos
    repos = GithubService.new.find_repos
    repos.sample(5)
  end
end
