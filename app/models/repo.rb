class Repo
  attr_reader :name, :html_url

  def initialize(params = {})
    @name = params[:name]
    @html_url = params[:html_url]
  end
end
