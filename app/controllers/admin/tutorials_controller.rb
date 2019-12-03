class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    tutorial = Tutorial.create(new_tutorial_params)
    video = tutorial.videos.create(new_video_params)
    if tutorial.save && video.save
      redirect_to "/tutorials/#{tutorial.id}"
    else
      @tutorial = Tutorial.new
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
    params.require(:tutorial).permit(:tag_list)
  end

  def new_tutorial_params
    params.require(:tutorial).permit(:title, :description, :thumbnail)
  end

  def new_video_params
    params.require(:tutorial).permit(:video_id, :description)
  end
end
