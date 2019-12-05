class Repo
  attr_reader :name, :html_url

  def initialize(name, html_url)
    @name = name
    @html_url = html_url
  end
end
