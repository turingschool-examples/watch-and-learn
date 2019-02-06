class Github::SessionsController < ApplicationController

  def create
    current_user.github_token = auth_info[:credentials][:token]
    current_user.github_id = auth_info[:uid]
    current_user.github_name = auth_info[:extra][:raw_info][:login]
    if current_user.save
      session[:user_id] = current_user.id
    end
    redirect_to dashboard_path
  end

  private

  def auth_info
    request.env["omniauth.auth"]
  end

end
