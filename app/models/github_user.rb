# frozen_string_literal: true

class GithubUser
  attr_reader :github_id, :login, :html_url, :email

  def initialize(github_user_hash)
    @github_id = github_user_hash[:id]
    @login = github_user_hash[:login]
    @html_url = github_user_hash[:html_url]
    @email = github_user_hash[:email]
  end

  def show_add_friend_button?
    user? && not_already_added?
  end

  def user?
    User.find_by(github_id: @github_id)
  end

  def not_already_added?
    friend = User.find_by(github_id: github_id)
    !Friendship.where(friendship_user_id: friend.id).exists?
  end

  def email?
    email.present?
  end

  def not_exist?
    !github_id.present?
  end
end
