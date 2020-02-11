class UsersController < ApplicationController
  def show
    user = User.find(current_user.id)
    if user.token

      render locals: {
        search_results: GithubDataView.new(user)
      }

      # conn = Faraday.new(url: 'https://api.github.com') do |f|
      #   f.headers['Authorization'] = "token #{user.token}"
      #   f.adapter Faraday.default_adapter
      # end
      #
      # repo_response = conn.get('/user/repos')
      # repo_hash = JSON.parse(repo_response.body, symbolize_names: true)[0..4]
      # @repos = repo_hash.map do |repo_data|
      #   Repo.new(repo_data)
      # end
      #
      # follower_response = conn.get('/user/followers')
      # follower_hash = JSON.parse(follower_response.body, symbolize_names: true)
      # @followers = follower_hash.map do |follower_data|
      #   Follower.new(follower_data)
      # end
      #
      # following_resp = conn.get('/user/following')
      # following_hash = JSON.parse(following_resp.body, symbolize_names: true)
      # @following = following_hash.map do |following_data|
      #   Following.new(following_data)
      # end
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

  def update
    user = User.find(params[:id])
    user.update(user_params)
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :token)
  end
end
