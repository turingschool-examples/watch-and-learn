class NotificationsController < ApplicationController
  def create
    github_user_profile_hash = GithubService.new(current_user).get_specific_user(params[:github_username])
    to_be_emailed_user_email = github_user_profile_hash[:email] 
    if to_be_emailed_user_email == nil 
      flash[:notice] = "No email present for this user"
    elsif 
      UserNotifierMailer.inform(current_user, to_be_emailed_user_email).deliver_now
      flash[:notice] = "Successfully Sent Invite"
    end

    redirect_to "/dashboard" 
  end
end
