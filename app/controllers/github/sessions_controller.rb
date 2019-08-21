class Github::SessionsController < ApplicationController
	def create
		user_info = request.env['omniauth.auth']
		User.find_or_create_by(id: user_info["id"])
	end
end
