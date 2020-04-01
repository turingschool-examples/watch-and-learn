class Admin::BaseController < ApplicationController
  before_action :require_admin!

  def require_admin!
    four_oh_four unless current_user.admin?
  end

  def current_user
    @current_user ||= if session[:user_id]
                        User.find(session[:user_id])
                      else
                        User.new
                      end
  end
end
