# frozen_string_literal: true

module Admin
  class DashboardController < Admin::BaseController
    def show
      @facade = AdminDashboardFacade.new
    end
  end
end
