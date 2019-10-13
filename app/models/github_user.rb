class GithubUser
  attr_reader :name, :link, :picture

  def initialize(params = {})
    @name = params[:login]
    @link = params[:html_url]
    @picture = params[:avatar_url]
  end
end
