class InviteController < ApplicationController

  def new

  end

  def create
    InviteMailer.invite(current_user, params[:email]).deliver_now
    flash[:success] = "Successfully sent invite!"
    redirect_to dashboard_path
  end
end
