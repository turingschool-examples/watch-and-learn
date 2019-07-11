# frozen_string_literal: true

class InvitesController < ApplicationController
  def new; end

  def create
    data = service.email_search(params[:invite])
    if data[:email]
      email = data[:email]
      name = data[:name]
      InviterMailer.invite(current_user, name, email).deliver_now
      flash.notice = 'Successfully sent invite!'
      redirect_to dashboard_path
    elsif data[:message]
      flash.notice = 'Not a valid Github Handle'
      redirect_to dashboard_path
    else
      msg = "The Github user you selected doesn't \
        have an email address associated with their account."
      flash.notice = msg
      redirect_to dashboard_path
    end
  end

  private

  def service
    GithubService.new(current_user)
  end
end
