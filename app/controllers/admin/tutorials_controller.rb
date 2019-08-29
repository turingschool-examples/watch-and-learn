class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    tutorial = Tutorial.new(tutorial_params)
    if tutorial.save
      flash[:notice] = "Successfully created tutorial."
      redirect_to tutorial_path(tutorial.id)
    else
      flash[:notice] = "Try again, something didn't go quite right."
      render :new  
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
    params.require(:tutorial).permit(:tag_list, :title, :description, :thumbnail)
  end
end
