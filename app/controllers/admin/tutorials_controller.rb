class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    tutorial = Tutorial.create(tutorial_params)
    video = tutorial.videos.create!(title: params["tutorial"]["video"]["title"], description: params["tutorial"]["video"]["description"], video_id: params["tutorial"]["video"]["video_id"])
    if tutorial.save && video.save
      redirect_to "/tutorials/#{tutorial.id}"
      flash[:success] = "Successfully created tutorial."
    else
      flash[:error] = "Please fill in all fields to create this tutorial"
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
    params.require(:tutorial).permit(:title, :description, :thumbnail, :tag_list)
  end

  # def video_params
  #   params.require(:video).permit()
  # end
end
