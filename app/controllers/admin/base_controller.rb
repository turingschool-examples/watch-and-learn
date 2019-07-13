# frozen_string_literal: true

class Admin::BaseController < ApplicationController
  before_action :require_admin!

  def require_admin!
    four_oh_four unless current_user.admin?
  end

  def four_oh_four
    render file: 'public/404', status: 404
  end
end
