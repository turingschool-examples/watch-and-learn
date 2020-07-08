class InviteController < ApplicationController
  def new; end

  def create
    results = GithubResults.new(current_user)
    email = results.user_email(params[:github_username])
    if email == 'Not Found'
      no_github_username
    elsif email.nil?
      github_no_email
    else
      github_email(email)
    end
  end

  private

  def no_github_username
    flash[:error] = 'There is no Github user with that username.'
    render :new
  end

  def github_no_email
    flash[:notice] = "The Github user you selected doesn't have an email
                      address associated with their account."
    redirect_to dashboard_path
  end

  def github_email(email)
    flash[:success] = 'Successfully sent invite!'
    InvitationMailer.invite(params[:github_username],
                            current_user.github_username,
                            email).deliver_now
    redirect_to dashboard_path
  end
end
