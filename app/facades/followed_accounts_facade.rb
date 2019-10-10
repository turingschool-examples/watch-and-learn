class FollowedAccountsFacade
  def create_followed_accounts(current_user)
    get_followed_account_data(current_user).map do |followed_account|
      FollowedAccount.new(followed_account)
    end
  end

  def get_followed_account_data(current_user)
    GithubSearchResults.new(current_user).followed_accounts

  end
end
