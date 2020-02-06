class GithubInfo
  attr_reader :name, :html
  def initialize(info)
    @name = info[:name]
    @html = info[:html_url]
  end
end
