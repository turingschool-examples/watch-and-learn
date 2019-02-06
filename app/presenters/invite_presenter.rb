class InvitePresenter
  def initialize(user, github_handle)
    @user = user
    @github_handle = github_handle
  end
  
  def invitee_info
    GithubService.new(@user).info_by_username(@github_handle)
  end
  
  def inviter_info
    GithubService.new(@user).user_info
  end
end