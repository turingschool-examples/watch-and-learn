class Githubber
  attr_reader :name, :url

  def initialize(githubber_data)
    @name = githubber_data["login"]
    @url = githubber_data["html_url"]
  end

end
