class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    tutorial = Tutorial.new(new_tutorial_params)
    if tutorial.save
      flash[:success] = "Successfully created tutorial."
      redirect_to tutorial_path(tutorial.id)
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
    if tutorial.update(tutorial_params)
      flash[:success] = "#{tutorial.title} tagged!"
    end
    redirect_to edit_admin_tutorial_path(tutorial)
  end

  def destroy
    tutorial = Tutorial.find(params[:id])
    flash[:success] = "#{tutorial.title} tagged!" if tutorial.destroy
    redirect_to admin_dashboard_path
  end

  private

  def tutorial_params
    params.require(:tutorial).permit(:tag_list)
  end

  def new_tutorial_params
    if params[:tutorial][:playlist_id] == ""
      params.require(:tutorial).permit(:title, :description, :thumbnail)
    else
      params.require(:tutorial).permit(
        :title, :description, :thumbnail, :playlist_id
      )
    end
  end
end
