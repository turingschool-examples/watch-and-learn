class Admin::DashboardController < Admin::BaseController
  def show
    render locals: {
      facade: AdminDashboardFacade.new
      }
  end
end
