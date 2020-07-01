class Repo
  attr_reader :id, :name, :html_url

  def initialize(parsed_resp)
    @id = parsed_resp[:id]
    @name = parsed_resp[:name]
    @html_url = parsed_resp[:html_url]
  end
end
