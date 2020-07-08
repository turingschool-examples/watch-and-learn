class UsersController < ApplicationController
  def show
    @github_service = GithubService.new
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  def update
    client_id     = "d5a0931835eac87a13b5"
    client_secret = "ded730dd722680ef599833bde6d40973bf693faf"
    code          = params[:code]
    response      = Faraday.post("https://github.com/login/oauth/access_token?client_id=#{client_id}&client_secret=#{client_secret}&code=#{code}")

    pairs = response.body.split("&")
    response_hash = {}
    pairs.each do |pair|
      key, value = pair.split("=")
      response_hash[key] = value
    end

    token = response_hash["access_token"]

    oauth_response = Faraday.get("https://api.github.com/user?access_token=#{token}")

    auth = JSON.parse(oauth_response.body)

    user = User.find(current_user.id)

    user.update_attribute(:token, token)

    redirect_to dashboard_path
  end


  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :username, :user_id, :token, :github)
  end
end
