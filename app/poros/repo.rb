class Repo
  attr_reader :name, :link 
  def initialize(repo_hash)
    @name = repo_hash[:name]
    @link = repo_hash[:html_url]
  end
end
