class UsersController < ApplicationController
  def show
    return unless current_user.github_token

    conn = Faraday.new(url: 'https://api.github.com') do |faraday|
      faraday.headers['Authorization'] = "token #{current_user.github_token}"
    end
    github_resp = conn.get('/user/repos')
    @parsed_resp = JSON.parse(github_resp.body, symbolize_names: true)[0..4]
    @parsed_resp.map! do |resp|
      Repo.new(resp)
    end
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
