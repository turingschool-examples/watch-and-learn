class Github::SessionsController < ApplicationController
  def create
    github_user_info = request.env['omniauth.auth']
    current_user.update!(github_token: github_user_info[:credentials][:token],
                         github_username: github_user_info[:extra][:raw_info][:login])
    redirect_to dashboard_path
  end
end
