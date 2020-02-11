class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    tutorial = Tutorial.create(tutorial_params)
    if tutorial.save
      redirect_to "/tutorials/#{tutorial.id}"
      flash[:success] = "Successfully created tutorial."
    else
      redirect_to "/admin/tutorials/new"
      flash[:error] = "Please fill in all fields"
    end
  end

  def new
    @tutorial = Tutorial.new
  end

  def update
    tutorial = Tutorial.find(params[:id])
    if tutorial.update(tutorial_params)
      flash[:success] = "#{tutorial.title} tagged!"
    end
    redirect_to edit_admin_tutorial_path(tutorial)
  end

  private
  def tutorial_params
    params.require(:tutorial).permit(:title, :description, :thumbnail, :tag_list)
  end
end
