class Repo
  attr_reader :name, :html_url
  def initialize(repo_hash)
    @name = repo_hash[:name]
    @html_url = repo_hash[:html_url]
  end
end
