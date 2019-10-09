class Repo
  attr_reader :name, :html_url

  def initialize(hash)
    @name = hash[:name]
    @html_url = hash[:html_url]
  end
end
