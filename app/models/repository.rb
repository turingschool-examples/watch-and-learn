class Repository
  attr_reader :url, :name
  def initialize(attributes)
    @url = attributes[:html_url]
    @name = attributes[:name]
  end
end
