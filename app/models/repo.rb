class Repo
  attr_reader :name, :url

  def initialize(repo)
    @name = repo[:name]
    @url = repo[:html_url]
  end

end
