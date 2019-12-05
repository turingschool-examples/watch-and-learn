class UsersController < ApplicationController
  def show

    # render locals: {
    #   search_results: UserInfo.new
    # }



    access_token = '91df31c63511d25ac644207816e8d86b4c8e92a2'
    conn = Faraday.new(url: 'https://api.github.com') do |faraday|
      faraday.params['access_token'] = access_token
      faraday.adapter Faraday.default_adapter
    end

    response = conn.get('/user/repos')
    json = JSON.parse(response.body, symbolize_names: true)
    @repos = json.take(5)
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
