class FollowingInfo
  attr_reader :name, :html
  def initialize(name, url)
    @name = name
    @html = url
  end
end

