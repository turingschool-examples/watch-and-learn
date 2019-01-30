class Repo
 attr_reader :url, :name
  def initialize(gh_response)
    @url = gh_response["html_url"]
    @name = gh_response["name"]
  end

  def self.generate(gh_response)
    JSON.parse(gh_response.body).map do |object|
      Repo.new(object)
    end
  end
end
