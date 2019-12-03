class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    tutorial = Tutorial.create(title: params["tutorial"]["title"], description: params["tutorial"]["description"], thumbnail: params["tutorial"]["thumbnail"])
    redirect_to "/tutorials/#{tutorial.id}"
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
    params.require(:tutorial).permit(:tag_list)
  end
end
