class Following
	attr_reader :login, :url

	def initialize(data = {})
		@login = data[:login]
		@url = data[:html_url]
	end
end
