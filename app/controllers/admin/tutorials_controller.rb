# frozen_string_literal: true

class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    tutorial = Tutorial.create(new_tutorial_params)
    if tutorial.save
      flash[:message] = "Successfully created tutorial."
      redirect_to tutorial_path(tutorial.id)
    else
      flash[:error] = 'Tutorial title already exists.'
      redirect_to new_admin_tutorial_path
    end
  end

  def new
    @tutorial = Tutorial.new
  end

  def update
    tutorial = Tutorial.find(params[:id])
    flash[:success] = "#{tutorial.title} tagged!" if tutorial.update(tut_params)

    redirect_to edit_admin_tutorial_path(tutorial)
  end

  private

  def tut_params
    params.require(:tutorial).permit(:tag_list)
  end

  def new_tutorial_params
    params.require(:tutorial).permit(:title, :description, :thumbnail, :playlist_id, :classroom)
  end
end
