class Repo
 attr_reader :url
  def initialize(gh_response)
    @url = gh_response["html_url"]
  end
end
