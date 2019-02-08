 class Admin::TutorialsController < Admin::BaseController

  def new
    @tutorial = Tutorial.new
    @tutorial.videos.build
  end

  def create
    @tutorial = Tutorial.new(tutorial_params)
    if @tutorial.save
      flash[:success] = "Successfully created tutorial!"
      redirect_to tutorial_path(@tutorial)
    else
      render :new
    end
  end

  def edit
    @tutorial = Tutorial.find(params[:id])
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
    params.require(:tutorial).permit(:title, :description, :thumbnail, videos_attributes: [:title, :description, :video_id, :thumbnail, :position])
  end
end
