class GithubHandle
  attr_reader :path, :name
  def initialize(data, user_friendships)
    @path = data[:html_url]
    @name = data[:login]
    @friend = user_friendships.include? data[:id]
  end

  def friend?; @friend end
end
