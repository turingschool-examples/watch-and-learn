class InviteController < ApplicationController
  def new
  end

  def create
    email = service.get_email(params[:handle])
    if email != nil
      FriendInviteMailer.invite(current_user, params[:handle], email).deliver_now
      service.get_email(params[:handle])
      flash[:success] = "Successfully sent invite!"
      redirect_to dashboard_path
    else
      flash.now[:error] = "The github user you selected doesn't have a valid email address associated with their account."
      render :new
    end
  end


  private
    def service
      GithubService.new(current_user)
    end
end
