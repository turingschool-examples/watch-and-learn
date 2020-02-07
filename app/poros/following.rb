class Following 
  attr_reader :name, :profile_path
  def initialize(info)
    @name = info[:login]
    @profile_path = info[:html_url]
  end
end
