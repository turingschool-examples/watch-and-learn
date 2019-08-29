class InviteController < ApplicationController

  def new
     @invite = Invite.new

  end

  def create
    user = User.find_by(params[:invite][:login])

    if user == nil
      flash[:error] = "The Github user you selected doesn't have an email address associated with their account."
    else
      flash[:success] = "Successfully sent invite!"
    end
    redirect_to dashbard_path
  end

    # ActivatinMailer.notify(@user).deliver
end
