class Repo
  attr_reader :name, :url
  def initialize(data)
    @name = data[:name]
    @url = data[:html_url]
  end

  def self.find_repos(user)
    repos = GithubService.new.find_repos(user)
    repos.sample(5)
  end
end
