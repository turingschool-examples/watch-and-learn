class Repo
  attr_reader :html_url, :name
  def initialize(attributes)
    @html_url = attributes[:html_url]
    @name = attributes[:name]
  end

end
