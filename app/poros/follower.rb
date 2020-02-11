class Follower
  attr_reader :name, :profile_path, :id
  def initialize(info, user)
    @name = info[:login]
    @profile_path = info[:html_url]
    if user == nil
      @id = nil
    else 
      @id = user.id
    end 
  end

  def with_us
    self.id != nil
  end 
end
