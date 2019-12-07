class Follower
  attr_reader :handle, :link, :id

  def initialize(follower_hash)
    @handle = follower_hash[:login]
    @link = follower_hash[:html_url]
    @id = nil
    in_db?
  end

  private
  def in_db?
    user = User.find_by(handle: @handle)
    @id = user.id if user
  end
end
