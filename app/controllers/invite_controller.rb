class InviteController < ApplicationController
  def show
  end


  def create
    friend_email = EmailFacade.new(current_user, params[:github_handle])
    the_email = friend_email.find_the_email
    InviteNotifierMailer.inform(current_user, the_email).deliver_now
    flash[:notice] = "Successfully sent invite!"
    redirect_to dashboard_path
  end

end
