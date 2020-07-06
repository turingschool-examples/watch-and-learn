class UsersController < ApplicationController

  def show
    if !current_user.github_token.nil?
      search_results = SearchResults.new
      @repos = search_results.repos
      @followers = search_results.followers
      @followings = search_results.followings
      # conn = Faraday.new("https://api.github.com")
      # response = conn.get("/user/repos?access_token=#{current_user.github_token}")
      #
      # json = JSON.parse(response.body, symbolize_names: true)
      # @repos = json[0..4].map do |user_data|
      #   Repo.new(user_data)
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
      flash[:error] = user.errors.full_messages.to_sentence
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end

# conn = Faraday.new("https://api.github.com") do |req|
#       req.headers['Authorization'] = "token #{ENV["GITHUB_ACCESS_TOKEN"]}"
#     end
# response = conn.get("/user/repos")
