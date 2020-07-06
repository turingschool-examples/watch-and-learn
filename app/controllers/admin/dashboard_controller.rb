class Admin::DashboardController < Admin::BaseController
  def show
    if params[:tutorial] == "create"
      tutorial = Tutorial.last
      flash[:success] = %Q[Successfully created tutorial. To view click here <a href="/tutorials/#{tutorial.id}">"#{tutorial.title}"</a>].html_safe
    end
    @facade = AdminDashboardFacade.new
  end

end
