class InviteController < ApplicationController
  def new
  end

  def create
    github_handle = params[:invite][:github_handle]
    response = GithubService.new(current_user.github_token).user(github_handle)
    AccountInviteMailer.invite(response[:name], response[:email], current_user)
    flash[:success] = 'Successfully sent invite!'
    redirect_to dashboard_path
  end
end
