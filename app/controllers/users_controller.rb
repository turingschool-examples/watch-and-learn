class UsersController < ApplicationController
  def show
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      user.confirmation_procedure
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      redirect_back(fallback_location: root_url)
    end
  end

  def confirm_email
    user = User.find_by_confirm_token(params[:token])
     if user
       user.validate_email
       user.save(validate: false)
       redirect_to user
     else
       flash[:error] = "Sorry. User does not exist"
       redirect_to root_url
   end
 end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

end
