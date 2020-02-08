class GithubController < ApplicationController
  def update
    @user = current_user
    @user.update(user_hash)
    redirect_to dashboard_path
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

  private

  def user_params
    params.permit(:uid, :token)
  end

  def user_hash
    {uid: auth_hash["uid"], token: auth_hash["credentials"]["token"]}
  end

end
