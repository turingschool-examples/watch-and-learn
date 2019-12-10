class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    tutorial = Tutorial.new(tutorial_params)
    if tutorial.save
      flash[:notice] = 'Successfully created tutorial!'
      redirect_to tutorial_path(tutorial)
    else
      flash[:error] = tutorial.errors.full_messages.to_sentence
      redirect_to new_admin_tutorial_path
    end
  end

  def new
    @tutorial = Tutorial.new
  end

  def update
    tutorial = Tutorial.find(params[:id])
    if tutorial.update(tag_params)
      flash[:success] = "#{tutorial.title} tagged!"
    end
    redirect_to edit_admin_tutorial_path(tutorial)
  end

  def destroy
    Tutorial.destroy(params[:id])
    redirect_to admin_dashboard_path
  end

  private
  def tag_params
    params.require(:tutorial).permit(:tag_list)
  end

  def tutorial_params
    params.require(:tutorial).permit(:title, :description, :thumbnail, :playlist_id, :classroom)
  end
end
