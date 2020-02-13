class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def new
    @tutorial = Tutorial.new
  end

  def destroy
    Tutorial.destroy(params[:id])
    flash[:notice] = 'Tutorial and related videos deleted.'
    redirect_to '/admin/dashboard'
  end

  def create
    @tutorial = Tutorial.new(new_tutorial_params)
    if @tutorial.save
      redirect_to tutorial_path(@tutorial.id),
                  success: 'Successfully created tutorial.'
    else
      flash.now[:error] = @tutorial.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    tutorial = Tutorial.find(params[:id])
    flash[:success] = "#{tutorial.title} tagged!" if tutorial.update(tutorial_params)
    redirect_to edit_admin_tutorial_path(tutorial)
  end

  private

  def tutorial_params
    params.require(:tutorial).permit(:tag_list)
  end

  def new_tutorial_params
    params.require(:tutorial).permit(:title, :description, :thumbnail)
  end
end
