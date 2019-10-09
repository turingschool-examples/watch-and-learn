class UsersController < ApplicationController
  def show
    @repos = get_repos
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

  def get_repos
    conn = Faraday.new('https://api.github.com/',
      headers: {'Authorization' => "bearer #{ENV['GITHUB_API_KEY']}"}
    )

    response = conn.get('user/repos', params: {'affiliation' => 'owner'})
    parsed_data = JSON.parse(response.body, symbolize_names: true)
    binding.pry
  end
end
