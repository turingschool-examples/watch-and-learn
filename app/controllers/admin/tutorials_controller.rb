class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    Tutorial.create(tutorial_params)
    redirect_to admin_dashboard_path
  end

  def new
    @tutorial = Tutorial.new
  end

  def update
    tutorial = Tutorial.find(params[:id])
    if tutorial.update(tutorial_tag_params)
      flash[:success] = "#{tutorial.title} tagged!"
    end
    redirect_to edit_admin_tutorial_path(tutorial)
  end

  private
  def tutorial_tag_params
    params.require(:tutorial).permit(:tag_list)
  end

  def tutorial_params
    params.require(:tutorial).permit(:title,:description,:thumbnail)
  end
end
