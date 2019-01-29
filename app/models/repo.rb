class Repo
 attr_reader :url
  def initialize(gh_response)
    @url = gh_response["html_url"]
  end

  def self.generate(gh_response)
    JSON.parse(gh_response.body).map do |object|
      Repo.new(object)
    end
  end
end
