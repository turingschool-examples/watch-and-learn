class Github::SessionsController < ApplicationController
	def create
		user_info = request.env['omniauth.auth']
		cred = current_user.user_credentials.find_or_create_by(website: "github")
		cred.update_attributes(token: user_info["credentials"]["token"])
		cred.save
		session[:github_id] = user_info["uid"]
		redirect_to dashboard_path
	end
end
