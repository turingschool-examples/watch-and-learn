class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    tutorial = Tutorial.new(new_tutorial_params)
    if tutorial.save
      new_tutorial_redirect(tutorial)
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
    if params[:tutorial][:playlist_id] == ''
      params.require(:tutorial).permit(:title, :description, :thumbnail)
    else
      params.require(:tutorial).permit(
        :title, :description, :thumbnail, :playlist_id
      )
    end
  end

  def new_tutorial_redirect(tutorial)
    if tutorial.playlist_id.nil?
      flash[:success] = 'Successfully created tutorial.'
      redirect_to tutorial_path(tutorial.id)
    else
      tutorial.add_playlist_videos
      flash[:success] = "Successfully created tutorial. #{view_context.link_to(
        'View it here.', tutorial_path(tutorial.id)
      )}"
      redirect_to admin_dashboard_path
    end
  end
end
