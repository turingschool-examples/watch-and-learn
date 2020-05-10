class UserAuthController < ApplicationController
  def create
    response = request.env['omniauth.auth']
    current_user.update(github_auth_params(response))
    flash[:success] = 'Successfully logged in through GitHub.'
    redirect_to dashboard_path
  end

  private

  def github_auth_params(response)
    {
      uid: response[:uid],
      token: response[:credentials][:token]
    }
  end
end
