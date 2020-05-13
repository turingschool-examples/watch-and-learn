require './app/poros/github/response.rb'

class InviteController < ApplicationController
  def new; end

  def create
    user_info = invitee_info
    if !user_info[:email].nil?
      send_invite(user_info)
      flash[:success] = 'Successfully sent invite!'
      redirect_to dashboard_path
    else
      flash[:error] = "The Github user you selected doesn't have an email address associated with their account."
      render :new
    end
  end

  private

  def invitee_info
    connection = Response.new(current_user)
    connection.user_info(params[:gh_username])
  end

  def send_invite(user_info)
    invitee_email = user_info[:email]
    email_info = invite_email_params(user_info)
    InviteMailer.inform(email_info, invitee_email).deliver_now
  end

  def invite_email_params(user_info)
    { inviter: current_user.full_name,
      invitee: user_info[:name] }
  end
end
