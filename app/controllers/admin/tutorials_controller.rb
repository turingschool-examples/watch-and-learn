class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    @tutorial = Tutorial.new(tutorial_create_params)
    successful_tutorial_creation_actions(@tutorial)    if @tutorial.save
    unsuccessful_tutorial_creation_actions        unless @tutorial.save
  end

  def new
    @tutorial = Tutorial.new
  end

  def update
    tutorial = Tutorial.find(params[:id])
    if tutorial.update(tutorial_update_params)
      flash[:success] = "#{tutorial.title} tagged!"
    end
    redirect_to edit_admin_tutorial_path(tutorial)
  end

  private

  def successful_tutorial_creation_actions(tutorial)
    flash[:success] = 'Successfully created tutorial.'
    redirect_to tutorial_path(tutorial)
  end

  def unsuccessful_tutorial_creation_actions
    render :new
  end

  def tutorial_update_params
    params.require(:tutorial).permit(:tag_list)
  end

  def tutorial_create_params
    params.require(:tutorial).permit(:title, :description, :thumbnail)
  end
end
