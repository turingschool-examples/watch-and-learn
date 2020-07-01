class UsersController < ApplicationController
  def show
    return unless current_user.github_token

    conn = Faraday.new(url: 'https://api.github.com') do |faraday|
      faraday.headers['Authorization'] = "token #{current_user.github_token}"
    end
    repo_resp = conn.get('/user/repos')
    @parsed_repo_resp = JSON.parse(repo_resp.body, symbolize_names: true)[0..4]
    @parsed_repo_resp.map! do |resp|
      Repo.new(resp)
    end
    followers_resp = conn.get('user/followers')
    @parsed_follow_resp = JSON.parse(followers_resp.body, symbolize_names: true)
    @parsed_follow_resp.map! do |follower|
      Follower.new(follower)
    end
    # require "pry"; binding.pry
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
