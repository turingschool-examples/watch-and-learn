class GithubConnectionController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]

    if User.github_uniq?(current_user, auth)
      GithubToken.create(token: auth.credentials.token, user: current_user)

      current_user.update_attribute(:uid, auth.uid)
      flash[:success] = "Your Github account is now linked."
    else
      flash[:error] = "That Github account is already in use."
    end
    redirect_to dashboard_path

  end
end
