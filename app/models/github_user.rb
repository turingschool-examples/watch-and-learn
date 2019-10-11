class GithubUser
  attr_reader :name

  def initialize(params = {})
    @name = params[:name]
    @link = params[:html_url]
    @picture = params[:avatar_url]
  end
end
