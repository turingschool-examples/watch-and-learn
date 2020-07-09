class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :list_tags
  helper_method :tutorial_name

  add_flash_types :success, :notice

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def tutorial_name(id)
    Tutorial.find(id).title
  end

  def four_oh_four
    raise ActionController::RoutingError, 'Not Found'
  end
end
