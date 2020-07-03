class RegUser::DashboardController < RegUser::BaseController
  def show
    @facade = RegUserDashboardFacade.new
  end
end