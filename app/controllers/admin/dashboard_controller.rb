# frozen_string_literal: true

class Admin::DashboardController < Admin::BaseController
  def show
    @facade = AdminDashboardFacade.new
  end
end
