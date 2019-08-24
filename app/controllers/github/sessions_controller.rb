class Github::SessionsController < ApplicationController
	def create
		user_info = request.env['omniauth.auth']
		token = user_info["credentials"]["token"]
		nickname = user_info["info"]["nickname"]
		current_user.add_credential("github", token, nickname)
		redirect_to dashboard_path
	end
end
