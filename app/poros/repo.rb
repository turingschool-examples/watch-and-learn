class Repo

  attr_reader :name, :link

  def initialize(repo_data)
    @name = repo_data[:name]
    @link = repo_data[:html_url]
  end
end
