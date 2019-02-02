class ActivateController < ApplicationController

  def show
    require "pry"; binding.pry
  end

  def update
    user = User.find(params[:id])
    user.update(activated: true)
    user.save
    flash[:notice] = "Thanks for activating your account!"
    session[:user_id] = user.id
    redirect_to dashboard_path
  end
end
