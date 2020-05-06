class UsersController < ApplicationController
  def show
    conn = Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.headers["Authorization"] = 'token 760f474f9836b5381968b12489a1ad211f177064'
    end
    repo = conn.get("/user/repos")
    json = JSON.parse(repo.body, symbolize_names: true)

    @list = []
    count = 0
    until count == 5
      @list << json[count][:full_name]
      count += 1
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
