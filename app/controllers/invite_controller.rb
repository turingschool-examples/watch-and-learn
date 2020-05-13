require './app/poros/github/results.rb'

class InviteController < ApplicationController 
  def new; end

  def create
    connection = Results.new(current_user)
    user_info = connection.user_info(params[:gh_username])
    if !user_info[:email].nil?
      invitee_email = user_info[:email]
      email_info = {inviter: current_user.full_name,
                    invitee: user_info[:name]}
      InviteMailer.inform(email_info, invitee_email).deliver_now
      flash[:success] = "Successfully sent invite!"
      redirect_to dashboard_path
    else 
      flash[:error] = "The Github user you selected doesn't have an email address associated with their account."
      render :new
    end
  end
end