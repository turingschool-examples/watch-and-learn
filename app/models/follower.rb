class Follower
attr_reader :handle,
            :url
  def initialize(attributes)
    @handle = attributes[:login]
    @url = attributes[:html_url]
  end
end
