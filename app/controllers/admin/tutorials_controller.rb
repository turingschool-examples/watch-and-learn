class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    @tutorial = Tutorial.new(tutorial_params)
    if @tutorial.save
      flash[:success] = "Successfully created \"#{@tutorial.title}\"."
      redirect_to tutorial_path(@tutorial)
    else
      flash[:errors] = "There are problems with the provided information."
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

  def destroy
    Tutorial.destroy(params[:id])
    redirect_to admin_dashboard_path
  end

  private
  def tutorial_params
    params.require(:tutorial).permit(:title, :description, :thumbnail, :tag_list)
  end
end
