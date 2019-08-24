class Follower
  attr_reader :login, :url

  def initialize(attributes = {})
    @login = attributes[:login]
		@url = attributes[:html_url]
  end

	def friendable?(login)
		 !UserCredential.where("nickname = ?", login).empty?		 
	end


end
