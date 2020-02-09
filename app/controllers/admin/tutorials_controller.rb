class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    @tutorial = Tutorial.create(tutorial_params)
    if @tutorial.save
      flash[:success] = 'Successfuly created tutorial'
      @tutorial.videos.create(video_params)
      redirect_to tutorial_path(@tutorial)
    else
      flash[:error] = @tutorial.errors.full_messages.to_sentence
      redirect_to new_admin_tutorial_path
    end
  end

  def new
    @tutorial = Tutorial.new
    @video = @tutorial.videos.build
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
    redirect_to '/admin/dashboard'
  end

  private

  def tutorial_params
    params.require(:tutorial).permit(:tag_list,
                                     :title, :description,
                                     :thumbnail)
  end

  def video_params
    params.require(:tutorial).require(:videos_attributes)["0"].permit(:title, :description, :video_id, :thumbnail)
  end
end
