class Follower
  attr_reader :name,
              :url,
              :uid

  def initialize(info)
    @name = info[:login]
    @url = info[:html_url]
    @uid = info[:id]
  end

  def in_data
     User.exists?(uid: @uid)
  end
end
