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
    code          = params[:code]
    response      = Faraday.post("https://github.com/login/oauth/access_token
                    ?client_id=#{ENV['CLIENT_ID']}&client_secret=#{ENV['CLIENT_SECRET']}
                    &code=#{code}")
    pairs = response.body.split("&")

    response_hash = {}
    pairs.each do |pair|
      key, value = pair.split("=")
      response_hash[key] = value
    end

    token = response_hash["access_token"]

    user = User.find(current_user.id)

    oauth_response = Faraday.get("https://api.github.com/user?access_token=#{token}")

    auth = JSON.parse(oauth_response.body)

    user.update_attribute(:token, token)
    user.update_attribute(:ghub_username, auth["login"])

    redirect_to dashboard_path
  end


  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :ghub_username, :token)
  end
end
