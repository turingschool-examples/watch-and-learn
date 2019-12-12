class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    @tutorial = Tutorial.create(new_tutorial_params)
    if @tutorial.save
      flash[:success] = 'Successfully created tutorial.'
      redirect_to tutorial_path(@tutorial)
    else
      flash.now[:error] = @tutorial.errors.full_messages.to_sentence
      render :new
    end
  end

  def new
    @tutorial = Tutorial.new
  end

  def update
    tutorial = Tutorial.find(params[:id])
    flash[:success] = "#{tutorial.title} tagged!" if tutorial.update(tutorial_params)
    redirect_to edit_admin_tutorial_path(tutorial)
  end

  def destroy
    tutorial = Tutorial.find(params[:id])
    tutorial.destroy
    redirect_to admin_dashboard_path
  end

  private

  def tutorial_params
    params.require(:tutorial).permit(:tag_list)
  end

  def new_tutorial_params
    params.require(:tutorial).permit(:title, :description, :thumbnail)
  end
end
