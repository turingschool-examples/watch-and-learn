class Repo
  attr_reader :name, :full_name, :html_url, :description
  def initialize(attributes)
    @name = attributes[:name]
    @full_name = attributes[:full_name]
    @html_url = attributes[:html_url]
    @description = attributes[:description]
  end
end
