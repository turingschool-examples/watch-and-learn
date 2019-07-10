class InvitesController < ApplicationController
  def new
  end

  def create
    data = service.email_search(params[:invite])
    if data[:email]
      email = data[:email]
    elsif data[:message]
      flash.notice = "Not a valid Github Handle"
      redirect_to invite_path
    else
      flash.notice = "The Github user you selected doesn't have an email address associated with their account."
    end
  end

  private

  def service
    GithubService.new(current_user)
  end
end
