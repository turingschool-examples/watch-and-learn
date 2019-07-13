# frozen_string_literal: true

class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create; end

  def new
    @tutorial = Tutorial.new
  end

  def update
    tutorial = Tutorial.find(params[:id])
    flash[:success] = "#{tutorial.title} tagged!" if tutorial.update(tut_params)

    redirect_to edit_admin_tutorial_path(tutorial)
  end

  def destroy
    tutorial = Tutorial.find(params[:id])
    tutorial.destroy
    flash[:success] = "Deleted tutorial '#{tutorial.title}' and associated videos."

    redirect_to admin_dashboard_path
  end

  private

  def tut_params
    params.require(:tutorial).permit(:tag_list)
  end
end
