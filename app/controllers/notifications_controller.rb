class NotificationsController < ApplicationController
  def create
    to_be_emailed_user = User.find_by(github_username: params[:github_username])
    UserNotifierMailer.inform(current_user, to_be_emailed_user.email).deliver_now
    flash[:notice] = "Successfully Sent Invite"
    redirect_to "/dashboard" 
  end
end
