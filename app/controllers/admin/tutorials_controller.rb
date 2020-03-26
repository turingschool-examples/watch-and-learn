class Admin::TutorialsController < Admin::BaseController
	require_relative './concerns/imageable.rb'
	include Imageable

  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
	tutorial = Tutorial.new(tutorial_create_params)
	if remote_file_image?(tutorial.thumbnail)
		if tutorial.save	
			flash[:success] = "Successfully created video."
			redirect_to admin_dashboard_path
		else
			flash[:error] = tutorial.errors.full_messages.to_sentence 
			redirect_back(fallback_location: admin_dashboard_path)
		end
	else
		flash[:error] = "link needs to be to an image"
		redirect_back(fallback_location: admin_dashboard_path)
	end	
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

  def destroy
    tutorial = Tutorial.find(params[:id])
    if tutorial.destroy
      flash[:success] = "#{tutorial.title} tagged!"
    end
    redirect_to admin_dashboard_path
  end

  private
  def tutorial_update_params
    params.require(:tutorial).permit(:tag_list)
  end

  def tutorial_create_params
	params.require(:tutorial).permit(:title, :description, :thumbnail)
  end
end
