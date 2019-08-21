class GithubRepo
  attr_reader :name,
              :url
  def initialize(repo_info)
    @name = repo_info[:name]
    @url = repo_info[:html_url]
  end
end
