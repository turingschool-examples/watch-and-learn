class UserAuthController < ApplicationController
  def create
    response = request.env['omniauth.auth']
    current_user.update(github_auth_params(response))
    if current_user.save
      flash[:success] = "Successfully logged in through GitHub."
      redirect_to dashboard_path
    else
      flash[:error] = "Test message"
      redirect_to dashboard_path
    end
  end

  private

  def github_auth_params(response)
    {
      uid: response[:uid],
      token: response[:credentials][:token]
    }
  end
end
