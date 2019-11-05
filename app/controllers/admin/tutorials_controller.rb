# frozen_string_literal: true

class Admin::TutorialsController < Admin::BaseController

  def new
    @tutorial = Tutorial.new
  end

  def create
    begin
      tutorial = Tutorial.create(tutorial_params)
      flash[:success] = "The tutorial has been created"
    rescue
      flash[:error] = "Something happen please retry!"
    end

    redirect_to tutorial_path(tutorial.id)
  end

  def edit
    @tutorial = Tutorial.find(params[:id])
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
    params.require(:tutorial).permit(:tag_list, :title, :description, :thumbnail)
  end
end
