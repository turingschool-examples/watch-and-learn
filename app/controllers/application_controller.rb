# frozen_string_literal: true

# application controller
class ApplicationController < ActionController::Base
  helper_method :current_user

  add_flash_types :success

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def active_current_user?
    if current_user.status == 'active'
    else
      flash[:notice] = 'Activate account before proceeding.'\
                       'Please check your email.'
      redirect_back fallback_location: { action: 'show', id: current_user.id }
    end
  end
end
