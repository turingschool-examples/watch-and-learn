class Follower
  attr_reader :handle, :url, :git_id
  def initialize(data)
    @handle = data[:login]
    @url  = data[:html_url]
    @git_id = data[:id]
  end
end
