class InvitesController < ApplicationController

  def new
  end

  def create
    no_email_redirect if json[:email] == nil
    email_invite_process(json[:email], json[:name]) if json[:email] != nil
  end

  private

  def no_email_redirect
    flash[:fail] = "The Github user you selected doesn't have an email address associated with their account."
    redirect_to dashboard_path
  end

  def email_invite_process(email, name)
    InviteMailer.invite(email, name)
    flash[:success] = "Successfully sent invite!"
    redirect_to dashboard_path
  end

  def json
    response = Faraday.get("https://api.github.com/users/#{params[:invite][:github_handle]}")
    json = JSON.parse(response.body, symbolize_names: true)
  end

end
