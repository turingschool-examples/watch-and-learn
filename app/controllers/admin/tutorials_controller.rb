# frozen_string_literal: true

class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
     @tutorial = Tutorial.create!(tutorial_params)
     video = @tutorial.videos.create!(video_params)
     # binding.pry
     redirect_to tutorial_path(@tutorial)
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
    params.require(:tutorial).permit(:tag_list, :title, :description, :thumbnail)
  end

  def video_params
    params.require(:tutorial).permit(:tag_list, :title, :description, :thumbnail)
  end

end
