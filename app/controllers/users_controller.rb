class UsersController < ApplicationController
  def show
    conn = Faraday.new(url: "https://api.github.com")

    response = conn.get("/user/repos?access_token=#{ENV['jenny_github_token']}")

    json = JSON.parse(response.body, symbolize_names: true)

    @repos = json[0..4]
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

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
