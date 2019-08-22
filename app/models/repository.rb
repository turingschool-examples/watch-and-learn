class Repository
  attr_reader :name, :full_name, :html_url


  def initialize(attributes = {})
    @name = attributes[:name]
    @full_name = attributes[:full_name]
    @html_url = attributes[:html_url]
  end
end
