class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :find_bookmark
  helper_method :list_tags
  helper_method :tutorial_name
  helper_method :github_user_exists?
  helper_method :already_friends?
  helper_method :get_status

  add_flash_types :success

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def find_bookmark(id)
    current_user.user_videos.find_by(video_id: id)
  end

  def tutorial_name(id)
    Tutorial.find(id).title
  end

  def four_oh_four
    raise ActionController::RoutingError, 'Not Found'
  end

  def github_user_exists?(login)
    User.find_by_ghub_username(login)
  end

  def already_friends?(current_user, login)
    new_friend_id = github_user_exists?(login).id
    if current_user.friendships.any? { |friend| friend.friend_id == new_friend_id }
      true
    else
      false
    end
  end

  def get_status
    if current_user.email_status
      "Active"
    else
      "Inactive"
    end
  end
end
