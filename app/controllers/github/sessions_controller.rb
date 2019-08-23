class Github::SessionsController < ApplicationController
	def create
		user_info = request.env['omniauth.auth']
		token = "token #{user_info["credentials"]["token"]}"
		current_user.add_credential("github", token)
		redirect_to dashboard_path
	end
end
