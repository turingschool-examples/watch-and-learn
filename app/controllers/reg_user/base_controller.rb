class RegUser::BaseController < ApplicationController
  before_action :require_user!

  def require_user!
    four_oh_four unless current_user && current_user.reg_user?
  end
end