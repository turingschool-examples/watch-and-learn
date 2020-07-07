class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Looks like your email or password is invalid'
      render :new
    end
  end

  def update
    auth_hash = request.env['omniauth.auth']
    current_user.update(github_token: auth_hash[:credentials][:token])
    redirect_to dashboard_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private
  # def auth_hash
  #   request.env['omniauth.auth']
  # end
end



# class SessionsController < ApplicationController
# def create
# auth = request.env["omniauth.auth"]
#  user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)     session[:user_id] = user.id     redirect_to root_url, :notice => "Signed in!"
#   end
