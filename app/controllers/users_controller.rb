class UsersController < ApplicationController
  def show
    return unless current_user.token
    @git_repos = GithubSearch.new.repos(current_user)
    

    # return unless current_user.token
    # conn = Faraday.new(url: "https://api.github.com") do |faraday|
    #   faraday.headers['Authorization'] = "token #{current_user.token}"
    # end
    #
    # response = conn.get("user/repos")
    #
    # parsed = JSON.parse(response.body, symbolized_names: true)[0..4]
    #
    # @links = Hash.new(0)
    #   parsed.map do |entry|
    #   @links[entry["name"]] = entry["url"]
    # end
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
