class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :find_bookmark
  helper_method :list_tags
  helper_method :tutorial_name
  helper_method :github_token

  add_flash_types :success

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def github_token
    @github_token ||= current_user.github_credentials if current_user.github_credentials
  end

  def find_bookmark(id)
    current_user.user_videos.find_by(video_id: id)
  end

  def tutorial_name(id)
    Tutorial.find(id).title
  end

  def four_oh_four
    raise ActionController::RoutingError.new('Not Found')
  end
end
